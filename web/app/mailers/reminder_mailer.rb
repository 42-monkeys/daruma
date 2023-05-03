# frozen_string_literal: true

class ReminderMailer < ApplicationMailer
  def reminder_email
    @user = params[:user]
    @reminder = params[:reminder]
    mail(to: @user.email, subject: 'The Daruma reminder')
  end
end
