Helplog::Application.routes.draw do
  root to: 'pages#home'

  resources :sessions
  resources :posts
end
