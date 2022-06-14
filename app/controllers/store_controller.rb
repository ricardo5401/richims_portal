class StoreController < ApplicationController
  def index
    javascript_links(["https://www.paypal.com/sdk/js?client-id=#{ENV['PAYPAL_CLIENT_ID']}&components=buttons"])
    @packs = Pack.where(status: 'active')
                 .includes(:pack_items)
  end

  def orders
    page = params[:page] || 1
    @orders = Nxcode.where(account_id: current_id)
                    .paginate(page: page, per_page: 20)
  end

  def create_order
    if @user_signed_in
      result = Paypal::Item.new(@current_user, params).generate_code!
      if result.success?
        render json: { code: result.unlock.code }, status: :accepted
      else
        render json: { error: result.error }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Usuario inválido' }, status: :unprocessable_entity
    end
  end
end
