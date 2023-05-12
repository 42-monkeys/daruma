# frozen_string_literal: true

json.extract! reminder, :id, :body
json.url resolution_reminders_url(reminder, format: :json)
