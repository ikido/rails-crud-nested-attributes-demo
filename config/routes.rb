Rails.application.routes.draw do
  resources :users

  root 'home#index'
  resources :contacts
  resources :assignments
  resources :clients do
    resources :contacts
    resources :assignments
  end
end
