Helplog::Application.routes.draw do
  root to: 'posts#published'

  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create', as: :sessions
  delete 'logout', to: 'sessions#destroy', as: :logout

  resources :posts do
    collection do
      get 'unpublished'
      get 'published'
    end
  end
end
