# frozen_string_literal: true

class Reminder < ApplicationRecord
  validates :body, presence: true

  belongs_to :resolution
  has_one :user, through: :resolution

  def created_at_formatted
    created_at.to_date.to_s
  end

  def remind
    send_notification
    send_email
    self.sent = true
    save
  end

  def send_notification
    android_device_tokens = user.devices.where(platform: 'android').pluck(:token)
    return if android_device_tokens.blank?

    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by(name: 'daruma')
    n.registration_ids = android_device_tokens
    n.content_available = true
    n.data = {
      title: 'The daruma reminder',
      message: body,
      temper:
    }

    n.save!
    Rpush.push
  end

  def send_email
    ReminderMailer.with(reminder: self).reminder_email.deliver_now
  end
end
