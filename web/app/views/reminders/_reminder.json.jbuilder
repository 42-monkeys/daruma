# frozen_string_literal: true

json.extract! reminder, :id, :body, :temper, :created_at_formatted
json.url resolution_reminders_url(reminder, format: :json)
