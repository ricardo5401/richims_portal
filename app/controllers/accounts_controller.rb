class AccountsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: :vote_callback
	skip_before_action :user_signed_in, only: [:logout, :create, :login, :vote_callback]
	skip_before_action :server_stats, only: [:unstuck, :logout, :create, :login, :vote_callback]

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

	def unlocked; end

	def unstuck
		if @user_signed_in
			Account.find(session[:current_user_id])&.update(loggedin: 0)
			redirect_to '/unlocked'
		else
			flash[:error] = "Not signed in?"
			redirect_to '/'
		end
	end

	def create
		account = Account.new(new_account_params)
		if check_valid_captcha(account)
			if !account.name || !account.email || Account.where("name = ? or email = ?", account.name, account.email).count.positive?
				flash[:error] = I18n.t('register.error')
				redirect_to '/register'
			else
				account.nxCredit = 0
				account.maplePoint = 0
				account.nxPrepaid = 0
				account.password = account.generate_password(params[:account][:password])
				account.tempban = DateTime.now - 5.years
				account.save!
				session[:current_user_id] = account.id
				redirect_to '/'
			end
		else
			flash[:error] = 'Invalid captcha!'
			redirect_to '/register'
		end
	end

	def register
		@account = Account.new
	end

	def vote_callback
		account = Account.find_by(name: params[:pingUsername])
		if account.present?
			account.nxCredit = 0 if !account.nxCredit
			account.nxCredit += 5000
			account.save!
		end
		redirect_to '/'
	end

	private

	def check_valid_captcha(account)
		if Rails.env.production?
			verify_recaptcha(model: account, action: 'registration')
		else
			true
		end
	end

	def new_account_params
		params[:account].permit(:name, :username, :email, :birthday)
	end
end
