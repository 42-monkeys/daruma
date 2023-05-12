# frozen_string_literal: true

namespace :daruma do
  desc 'Generate reminders jobs'
  task generate_reminders: [:environment] do
    Resolution.active.each do |resolution|
      puts "Generating reminder job for resolution #{resolution.id}"
      CreateRemindersJob.perform_later(resolution)
    end
    puts 'Reminders job generated'
  end
end
