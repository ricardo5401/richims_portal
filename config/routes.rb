Rails.application.routes.draw do
  get 'characters/index'
	root 'pages#index'
	get '/downloads', to: 'pages#downloads'
	get '/register', to: 'pages#register'
	get '/rankings', to: 'pages#rankings'
	get '/vote', to: 'pages#vote'
  get '/unstuck', to: 'pages#unstuck'
	post '/login', to: 'accounts#login'
	delete '/logout', to: 'accounts#logout', as: :logout
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
