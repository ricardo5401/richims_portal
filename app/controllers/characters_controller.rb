class CharactersController < ApplicationController
  def index
    if @user_signed_in
      @characters = Character.where(accountid: session[:current_user_id])
    else
      flash[:error] = 'You must log in'
      redirect_to '/login'
    end
  end
  def rankings
    @page = params[:page] || 1
    @per_page = 20
    @characters = Character.order(level: :desc, exp: :desc)
                           .paginate(page: @page, per_page: @per_page)
  end
end
