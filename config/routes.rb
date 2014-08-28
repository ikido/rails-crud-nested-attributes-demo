Rails.application.routes.draw do
  resources :users

  root 'home#index'
  resources :contacts
  resources :assignments

  resources :clients, shallow: true do
    resources :contacts
    #resources :assignments
  end
end
