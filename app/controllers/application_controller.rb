class ApplicationController < ActionController::Base
	around_action :switch_locale
	before_action :user_signed_in
	before_action :server_stats
	helper_method :current_user
	helper_method :javascript_links
	helper_method :current_id
	helper_method :admin_only
	helper_method :style_links


	private

	def javascript_links(arr = [])
		@javascript_links = arr
	end

	def style_links(arr = [])
		@style_links = arr
	end

	def current_user
		@current_user ||= Account.find_by(id: session[:current_user_id])
	end

	def admin_only
		unless @current_user && @current_user.webadmin > 0
			flash[:error] = 'You dont have permissions'
			redirect_to '/'
		end
	end

	def current_id
		@current_id ||= session[:current_user_id]
	end

	def user_signed_in
		@user_signed_in = (session[:current_user_id] || 0) > 0
	end

	def server_stats
		@online_count = Account.where(webadmin: 0).where.not(loggedin: 0).count
		@characters_count = Character.where(gm: [0, 1]).count
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
