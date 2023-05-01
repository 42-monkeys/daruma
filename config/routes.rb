# frozen_string_literal: true

Rails.application.routes.draw do
  resources :resolutions
  devise_for :users, controllers: { sessions: 'users/sessions' }
end
