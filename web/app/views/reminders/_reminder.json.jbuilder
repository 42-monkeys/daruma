# frozen_string_literal: true

json.extract! reminder, :id, :body
json.url reminder_url(reminder, format: :json)
