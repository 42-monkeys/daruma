# frozen_string_literal: true

class SendRemindersJob < ApplicationJob
  queue_as :default

  def perform(reminder)
    reminder.remind
  end
end
