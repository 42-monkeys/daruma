# frozen_string_literal: true

namespace :daruma do
  desc 'Generate reminders'
  task generate_reminders: [:environment] do
    Resolution.active.each do |resolution|
      puts "Generating reminder for resolution #{resolution.id}"
      reminder = resolution.generate_reminder
      puts "reminder body: #{reminder.body}" if reminder
    end
    puts 'Reminders generated'
  end
end
