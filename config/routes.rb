Helplog::Application.routes.draw do
  root to: 'pages#home'

  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create', as: :sessions
  delete 'logout', to: 'sessions#destroy', as: :logout
  get 'logout', to: 'sessions#destroy' # convenience for logging out
  resources :sessions

  resources :posts do
    collection do
      get 'unpublished'
      get 'published'
    end
  end
end
