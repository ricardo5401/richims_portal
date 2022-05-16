class ApplicationController < ActionController::Base
	around_action :switch_locale
	before_action :user_signed_in
	before_action :server_stats
	helper_method :current_user


	private

	def current_user
		@current_user ||= Account.find_by(id: session[:current_user_id])
	end

	def user_signed_in
		@user_signed_in = (session[:current_user_id] || 0) > 0
	end

	def server_stats
		@online_count = Account.where(gm: false).where.not(loggedin: 0).count
		@characters_count = Character.where(gm: 0).count
		@username = current_user&.name if @user_signed_in
	end

	def switch_locale(&action)
		locale = params[:locale] || session[:locale]
		if (I18n.available_locales - [I18n.default_locale]).map(&:to_s).exclude? locale
			locale = I18n.default_locale
		end
		session[:locale] = locale
		I18n.with_locale(locale, &action)
	end
end
