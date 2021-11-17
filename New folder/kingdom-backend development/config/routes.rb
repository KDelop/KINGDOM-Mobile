Rails.application.routes.draw do
  get 'users/prospect'
  get 'users/contacted'
  # users
  resources :users, only: [:update]
  # demos
  resources :demos do
    post :send_reminder
  end
  get '/settings', to: 'demos#settings', as: 'demo_settings'
  # availabilities
  resources :availabilities
  # leads
  resources :leads do
    member do
      patch :change_stage
    end
  end
  get '/lead_view', to: 'leads#lead_view', as: 'lead_view'
  get '/pipeline_view', to: 'leads#pipeline_view', as: 'pipeline_view'
  # users
  devise_for :users, controllers: { registrations: 'registrations', passwords: 'passwords' }

  get '/confirm_phone', to: 'static#confirm_phone', as: :confirm_phone
  post '/verify_otp', to: 'static#verify_otp', as: :verify_otp
  get '/after_sign_up', to: 'static#after_sign_up', as: :after_sign_up
  # registrations
  devise_scope :user do
    get 'registrations/new_subscription'
    get 'registrations/add_domain'
    get 'registrations/add_leads'
    post 'registrations/select_domain'
    post 'registrations/search_domain'
  end

  # CSV import route
  post 'leads/import', to: 'leads#import'

  resources :subscriptions
  # home page
  root 'static#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
