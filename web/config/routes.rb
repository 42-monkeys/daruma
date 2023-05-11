# frozen_string_literal: true

Rails.application.routes.draw do
  resources :resolutions, only: %i[index show new create] do
    get '/reminders', to: 'reminders#index'
  end
  devise_for :users

  get '/stats', to: 'stats#index'
end
