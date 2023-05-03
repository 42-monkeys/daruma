# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/reminder_mailer
class ReminderMailerPreview < ActionMailer::Preview
  def reminder_email
    user = User.first
    resolution = user.resolutions.first
    ReminderMailer.with(user:, reminder: resolution.reminders.first).reminder_email
  end
end
