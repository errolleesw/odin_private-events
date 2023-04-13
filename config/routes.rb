Rails.application.routes.draw do
  devise_for :users
  # root to: redirect('/users/sign_in')
  root 'users#show'
  # root 'devise/sessions#new'

  # devise_scope :user do
  #   get 'users/:id', to: 'devise/registrations#show', as: 'user'
  # end

  get 'users/:id', to: 'users#show', as: 'user'

  # add a new member route for events to handle the attendance section.
  resources :events do
    member do
      post 'attend'
    end
  end

  # set up standard routes for the event_attendees model
  resources :event_attendees
  # root 'devise/sessions#new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # resources :users
  # Defines the root path route ("/")
  # root "articles#index"
end
