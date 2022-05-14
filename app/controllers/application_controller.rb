class ApplicationController < ActionController::Base
	around_action :switch_locale
	before_action :user_signed_in
	before_action :server_stats


	private

	def user_signed_in
		@user_signed_in = (session[:current_user_id] || 0) > 0
		puts "try? #{@user_signed_in}"
	end

	def server_stats
		@online_count = Account.where.not(loggedin: 0).count
		@characters_count = Character.count
		@username = Account.select(:name).find_by(id: session[:current_user_id])&.name if @user_signed_in
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
