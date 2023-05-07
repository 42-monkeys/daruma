# frozen_string_literal: true

class Reminder < ApplicationRecord
  validates :body, presence: true

  belongs_to :resolution
  has_one :user, through: :resolution

  def remind
    send_email
    self.sent = true
    save
  end

  def send_notification
    # TODO: send to android
  end

  def send_email
    ReminderMailer.with(reminder: self).reminder_email.deliver_now
  end
end
