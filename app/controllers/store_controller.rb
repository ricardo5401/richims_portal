class StoreController < ApplicationController
  def index
    @packs = Pack.where(status: 'active')
                 .includes(:pack_items)
  end
end
