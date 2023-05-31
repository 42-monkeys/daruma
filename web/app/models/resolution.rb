# frozen_string_literal: true

class Resolution < ApplicationRecord
  validates :body, presence: true, length: { maximum: 150 }
  validates :commitment, presence: true
  validates :time_limit, presence: true
  validates :temper, presence: true
  validates :offer, allow_blank: true, numericality: { only_numeric: true, greater_than_or_equal_to: 0 }

  enum :commitment, %i[low moderate high], suffix: true
  enum :temper, %i[motivational sarcastic authoritarian random], suffix: true

  belongs_to :user
  has_many :reminders, dependent: :destroy

  scope :active, -> { where('time_limit > ?', Time.zone.today) }

  def cost
    gpt_cost_per_token = 0.002 / 1000
    total_token_tor_resolution = reminders.sum('prompt_tokens + completion_tokens')
    total_token_tor_resolution * gpt_cost_per_token
  end

  def generate_reminder
    return unless to_remind?

    ai_reminder = generate_ai_reminder
    reminder = Reminder.create(
      body: ai_reminder[:text],
      prompt_tokens: ai_reminder[:prompt_tokens],
      completion_tokens: ai_reminder[:completion_tokens],
      resolution: self
    )
    SendRemindersJob.perform_later(reminder)
  end

  def resolution_ended_notification
    ResolutionMailer.with(resolution: self).resolution_ended_email.deliver_now
  end

  def generate_ai_reminder
    if Rails.env.test? || Rails.env.development?
      return {
        prompt_tokens: 0,
        completion_tokens: 0,
        text: 'some generated text'
      }
    end

    client = OpenAI::Client.new

    response = client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: [{ role: 'user', content: prompt.squish }]
      }
    )

    {
      prompt_tokens: response.dig('usage', 'prompt_tokens'),
      completion_tokens: response.dig('usage', 'completion_tokens'),
      text: response.dig('choices', 0, 'message', 'content').gsub('`', '')
    }
  end

  def prompt
    ret = "write a #{temper_for_request} sentence to motivate me using at most
    50 words in #{user.language} for my proposition."

    if reminders.count.positive?
      ret += "must be different from these previous sentences, enclosed in double backticks:
        #{reminders.last(5).map { |r| "``#{r.body}``" }.join(' ')}"
    end

    ret += "The proposition is delimited with triple backticks ```#{body}```"
    ret
  end

  def temper_for_request
    return Resolution.tempers.excluding('random').keys.sample if random_temper?

    temper
  end

  def to_remind?
    return false if time_limit < Time.zone.today

    last_reminder_date = reminders.order(created_at: :desc).limit(1).pick(:created_at)&.to_date
    return true if last_reminder_date.nil?

    return true if low_commitment? && last_reminder_date + 7.days <= Time.zone.today
    return true if moderate_commitment? && last_reminder_date + 3.days <= Time.zone.today
    return true if high_commitment? && last_reminder_date + 1.day <= Time.zone.today

    false
  end
end
