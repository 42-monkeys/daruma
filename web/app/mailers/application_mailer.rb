# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'daruma@42monkeys.eu'
  layout 'mailer'
end
