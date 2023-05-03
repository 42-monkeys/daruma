# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/reminder_mailer
class ReminderMailerPreview < ActionMailer::Preview
  def reminder_email
    count = Reminder.count
    random_offset = rand(count)
    ReminderMailer.with(reminder: Reminder.offset(random_offset).first).reminder_email
  end
end
