Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :reservations, only: [:index, :show, :edit, :update]
  resources :users, only: [:show, :edit, :update]
  resource :profile, only: [:show, :edit, :update]

  resources :rooms do
    collection do
      get 'search'
    end

    resources :reservations, only: [:create, :index, :destroy, :edit, :update] do
      member do
        get 'confirm'
        post 'complete'
        get 'cancel'
      end
    end
  end
end