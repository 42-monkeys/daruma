# frozen_string_literal: true

namespace :rpush do
  desc 'Create Rpush android app'
  task android_app: [:environment] do
    Rpush::Gcm::App.create(
      name: 'daruma',
      connections: 1,
      environment: Rails.env,
      type: 'Rpush::Client::ActiveRecord::Gcm::App',
      auth_key: Rails.application.credentials[:android_server_key]
    )
    puts 'Rpush Android app created Successfully'
  end
end
