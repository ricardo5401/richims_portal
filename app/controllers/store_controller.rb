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

  def generate_gift
    if @current_user && @current_user.webadmin > 0
      code = create_gift
      render json: {
        order: {
          code: code.code,
          retriever: 'Not used',
          account: {
            id: code.account.id,
            name: code.account.name
          },
          pack: {
            name: code.pack.name,
            price: code.pack.price
          }
        }
      }, status: :created
    else
      render json: { order: nil, error: 'You dont have permission!' }, status: :unprocessable_entity
    end
  end

  private

  def create_gift
    exp = Nxcode.generate_expiration(50)
    code = Nxcode.generate(params[:pack_id], exp)
    code.order_id = "GIFT-#{SecureRandom.hex(6).upcase}"
    code.account_id = @current_user.id
    code.save!
    code
  end
end
