class PacksController < ApplicationController
	before_action :set_pack, only: [:show, :edit, :update]
	def index
		@packs = Pack.where(status: 'active')
		             .includes(:pack_items)
	end

	def new
	end

	def show
		page = params[:page] || 1
		@orders = Nxcode.where(pack_id: @pack&.id)
		                .paginate(page: page, per_page: 20)
	end

	def edit
	end

	def update
	end

	def create
	end

	private

	def set_pack
		@pack = Pack.find_by(id: params[:id])
	end
end
