Rails.application.routes.draw do
  get 'characters/index'
	root 'pages#index'
	get '/downloads', to: 'pages#downloads'
	get '/register', to: 'accounts#register'
	get '/rankings', to: 'characters#rankings'
	get '/vote', to: 'pages#vote'
  get '/characters', to: 'characters#index'
  get '/online_characters', to: 'characters#online'
  get '/unlocked', to: 'accounts#unlocked'
  post '/gtop100/callback', to: 'accounts#vote_callback'
  post '/unstuck', to: 'accounts#unstuck'
	post '/login', to: 'accounts#login'
  post '/accounts', to: 'accounts#create'
	delete '/logout', to: 'accounts#logout', as: :logout
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
