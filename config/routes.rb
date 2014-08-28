Rails.application.routes.draw do
  resources :users

  root 'home#index'

  resources :contacts, shallow: true do
    resources :assignments
  end

  resources :assignments do
    resource :workflow, only: [:new, :update, :show, :edit] do
      member do
        get :complete_current_stage
        get :cancel_current_stage
      end
    end
  end

  resources :workflows, only: [] 

  resources :clients, shallow: true do
    resources :contacts
  end

end
