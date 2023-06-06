# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/resolution_mailer
class ResolutionMailerPreview < ActionMailer::Preview
  def resolution_ended_email
    count = Resolution.count
    random_offset = rand(count)
    ResolutionMailer.with(resolution: Resolution.offset(random_offset).first).resolution_ended_email
  end
end
