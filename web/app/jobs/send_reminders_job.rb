# frozen_string_literal: true

class SendRemindersJob < ApplicationJob
  queue_as :default

  def perform(resolution)
    resolution.generate_reminder
  end
end
