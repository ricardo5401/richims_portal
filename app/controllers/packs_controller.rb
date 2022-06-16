class PacksController < ApplicationController
	before_action :set_pack, only: [:show, :edit, :update]
	before_action :set_item, only: :remove_item
	before_action :add_flowbite, only: [:new, :edit]

	def index
		page = params[:page] || 1
		@packs = Pack.includes(:pack_items)
		             .paginate(page: page, per_page: 20)
	end

	def new
		@pack = Pack.new
		@pack.price = 3.0
	end

	def show
		page = params[:page] || 1
		@orders = Nxcode.where(pack_id: @pack&.id)
		                .paginate(page: page, per_page: 20)
	end

	def edit
	end

	def update
		if @pack
			@pack.status = @pack.pack_items.count > 0 ? 'active' : 'inactive'
			@pack.assign_attributes(pack_params)
			if @pack.save!
				flash[:notice] = 'Pack was updated!'
				redirect_to '/packs'
			else
				flash[:error] = 'Error on update pack!'
				render 'packs/edit'
			end
		else
			flash[:error] = 'Pack not found!'
			render 'packs/new'
		end
	end

	def create
		@pack = Pack.new(pack_params)
		if @pack.save!
			redirect_to "/packs/#{@pack.id}/edit"
		else
			flash[:error] = 'Error on save pack!'
			render 'packs/new'
		end
	end

	def create_item
		@pack_item = PackItem.new(item_params)
		@pack_item.item_name = "#{Humanize.counter(@pack_item.quantity)} #{I18n.t "pack_item.#{@pack_item.item_type}" }" if @pack_item.item_type < 5
		if @pack_item.save!
			render json: {pack_item: @pack_item}, status: :accepted
		else
			render json: {error: @pack_item.errors}, status: :unprocessable_entity
		end
	end

	def remove_item
		@pack_item&.destroy

		render json: {message: 'Ok'}, status: :accepted
	end

	private

	def add_flowbite
		style_links(['https://unpkg.com/flowbite@1.4.7/dist/flowbite.min.css'])
		javascript_links(['https://unpkg.com/flowbite@1.4.7/dist/flowbite.js'])
	end

	def set_pack
		@pack = Pack.find_by(id: params[:id])
	end

	def set_item
		@pack_item = PackItem.find_by(id: params[:id])
	end

	def item_params
		params[:pack_item].permit(:item_type, :item_name, :item_id, :quantity, :pack_id)
	end

	def pack_params
		params[:pack].permit(:name, :price)
	end
end
