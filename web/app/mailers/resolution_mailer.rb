# frozen_string_literal: true

class ResolutionMailer < ApplicationMailer
  def resolution_ended_email
    @resolution = params[:resolution]
    @user = @resolution.user
    mail(to: @user.email, subject: 'Your resolution time is finished')
  end
end
