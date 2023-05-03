# frozen_string_literal: true

class ReminderMailer < ApplicationMailer
  def reminder_email
    @reminder = params[:reminder]
    @user = @reminder.user
    mail(to: @user.email, subject: 'The Daruma reminder')
  end
end
