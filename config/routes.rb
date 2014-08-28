Rails.application.routes.draw do
  resources :users

  root 'home#index'

  resources :contacts, shallow: true do
    resources :assignments
  end

  resources :assignments

  resources :clients, shallow: true do
    resources :contacts
  end

end
