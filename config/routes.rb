Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :kudos
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/me/kudos/received', to: 'kudos#received'
  get '/me/kudos/sent', to: 'kudos#sent'
  get '/me/kudos/total', to: 'users#total'

  get '/', to: 'pages#home'
end
