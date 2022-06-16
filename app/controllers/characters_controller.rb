class CharactersController < ApplicationController
  before_action :admin_only, only: :online

  def index
    if @user_signed_in
      @characters = Character.where(accountid: session[:current_user_id])
    else
      flash[:error] = 'You must log in'
      redirect_to '/login'
    end
  end

  def online
    @page = params[:page] || 1
    @per_page = 4
    @accounts = Account.where.not(loggedin: 0)
                       .includes(:characters)
                       .paginate(page: @page, per_page: @per_page)
  end

  def rankings
    @query = params[:query] || ''
    @page = (params[:page] || 1).to_i
    @per_page = 5
    @characters = Character.where(build_params)
                           .order(rank: :asc, level: :desc, exp: :desc)
                           .paginate(page: @page, per_page: @per_page)
  end

  private

  def build_params
    if @query != ''
      "lower(name) like '%#{@query.downcase}%' and gm < 2"
    else
      "gm < 2"
    end
  end
end
