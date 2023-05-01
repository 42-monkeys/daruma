# frozen_string_literal: true

json.extract! resolution, :id, :body, :time_limit, :commitment, :temper, :offer, :created_at, :updated_at
json.url resolution_url(resolution, format: :json)
