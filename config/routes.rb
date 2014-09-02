Rails.application.routes.draw do

  constraints :subdomain => "admin" do

    # Note: these custom devise routes just don't work with acts_as_tenant,
    # resulting in 'undefined devise mapping' exception for each route
    #
    # manual devise routes that allow just sign_in/sign_out as well
    # as password reset. They're manual because we want nice url, e.g.
    # admin.domain.com/sign_in
    # devise_scope :user do
      # devise#sessions routes
      # get 'sign_in' => 'devise/sessions#new' , :as => :new_user_session
      # post 'sign_in' => 'devise/sessions#create', :as => :user_session
      # delete 'sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session

      # devise#passwords routes
      # get 'password/new' => 'devise/passwords#new', :as => :new_user_password
      # post 'password' => 'devise/passwords#create', :as => :user_password
      # patch 'password' => 'devise/passwords#update'
      # put 'password' => 'devise/passwords#update'
      # get 'password/edit' => 'devise/passwords#edit', :as => :edit_user_password
    # end

    # we change default prefix for devise actions, for nicer url
    devise_for :users, path: 'account'

    # regular resources scoped with module, instead of namespace,
    # cause we already have a subdomain for url clarity
    scope :module => "admin", :as => "admin" do
      resources :accounts
    end
  end

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
