# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :polls do
    resources :votes, only: [:create]

    resources :questions do
      resources :answers, only: %i[new create edit update destroy]
    end
  end

  root 'polls#index'
end
