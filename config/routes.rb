Rails.application.routes.draw do
	root 'pages#index'
	get '/store', to: 'store#index'
	get '/downloads', to: 'pages#downloads'
	get '/register', to: 'accounts#register'
	get '/rankings', to: 'characters#rankings'
	get '/vote', to: 'pages#vote'
  get '/characters', to: 'characters#index'
  get '/online_characters', to: 'characters#online'
  get '/unlocked', to: 'accounts#unlocked'
	get '/orders', to: 'store#orders'
  post '/gtop100/callback', to: 'accounts#vote_callback'
  post '/unstuck', to: 'accounts#unstuck'
	post '/login', to: 'accounts#login'
  post '/accounts', to: 'accounts#create'
	post '/orders', to: 'store#create_order'
	delete '/logout', to: 'accounts#logout', as: :logout

	resources :packs
	post '/items', to: 'packs#create_item'
	delete '/remove_item/:id', to: 'packs#remove_item'
	post '/generate_gift', to: 'store#generate_gift'

	resources :notices
	get '/notices_admin', to: 'notices#admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
