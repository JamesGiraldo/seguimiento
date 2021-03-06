# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  namespace :admin do
    resources :ambientes
    # resources :fichas
    resources :especialidades do
      resources :programas, module: :especialidades
    end
    resources :programas do
      resources :fichas, module: :programas
    end
  end

  resources :comentarios

  resources :ambientes, only: %i[index show] do
    resources :anotaciones, module: :ambientes
  end


  devise_for :users

  resources :users, only: %i[index show] do
    resources :anotaciones, module: :users
  end

  patch '/users/:id', to: 'users#update'

  get 'toexcel', to: 'fichas#toexcel'

  resource :user, only: %i[index edit destroy update show] do
    get :ver_user, on: :member
    collection do
      patch 'update_password'
      get :change_password
    end
  end

  get "*any", via: :all, to: "application#catch_404"
end
