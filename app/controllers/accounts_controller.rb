class AccountsController < ApplicationController
	skip_before_action :user_signed_in, only: :logout
	skip_before_action :server_stats, only: :logout

	def login
		@account = Account.find_by(name: params[:username])
		if @account&.valid_password?(params[:password])
			session[:current_user_id] = @account.id
		else
			flash[:error] = I18n.t 'login.error'
		end
		redirect_to '/'
	end

	def logout
		session.delete(:current_user_id)
		redirect_to '/'
	end

	def unstuck
		render 'pages/under_construction'
	end

	def create
	end
end
