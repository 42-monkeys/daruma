# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :resolutions, only: %i[index show new create] do
    get '/reminders', to: 'reminders#index'
  end
  devise_for :users

  resources :devices, only: %i[create]

  authenticate :user, ->(user) { user.admin_role? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get '/stats', to: 'stats#index'
end
