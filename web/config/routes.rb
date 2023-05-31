# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :resolutions, only: %i[index show new create] do
    get '/reminders', to: 'reminders#index'
    get '/complete/:completed', to: 'resolutions#complete', as: :complete
  end
  devise_for :users

  authenticate :user, ->(user) { user.admin_role? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  authenticate :user do
    get '/forget_me', to: 'forget#index'
    post '/forget_me', to: 'forget#forget_me'
    resources :devices, only: %i[create]
  end

  get '/stats', to: 'stats#index'
end
