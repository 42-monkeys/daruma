# frozen_string_literal: true

Rails.application.routes.draw do
  resources :resolutions
  devise_for :users

  get '/stats', to: 'stats#index'
end
