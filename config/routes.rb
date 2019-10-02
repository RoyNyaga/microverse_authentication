Rails.application.routes.draw do
 	root 'posts#index'
  get 'posts/new'
  get 'posts/index'
  get    '/login',   to: 'session#new'
  post   '/login',   to: 'session#create'
  delete '/logout',  to: 'session#destroy'
  resources :users
  resources :sessions
  resources :posts, only: [:new, :create, :index]
end
