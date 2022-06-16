class NoticesController < ApplicationController
	before_action :set_notice, only: [:show, :edit, :update]
	before_action :add_ckeditor, only: [:new, :edit]

	def index
		page = params[:page] || 1
		@notices = Notice.where(status: 'active')
		             .paginate(page: page, per_page: 20)
	end

	def admin
		page = params[:page] || 1
		@notices = Notice.paginate(page: page, per_page: 20)
	end

	def new
		@notice = Notice.new
	end

	def show; end

	def edit; end

	def update
		if @notice
			@notice.assign_attributes(notice_params)
			@notice.status = 'active'
			if @notice.save!
				flash[:notice] = 'Notice was updated!'
				render json: { notice: @notice }, status: :accepted
			else
				render json: { error: 'Error on update notice!' }, status: :unprocessable_entity
			end
		else
			render json: { error: 'Notice not found!' }, status: :unprocessable_entity
		end
	end

	def create
		@notice = Notice.new(notice_params)
		@notice.created_at = DateTime.now
		@notice.status = 'active'
		if @notice.save!
			flash[:info] = 'Notice was created!'
			render json: { notice: @notice }, status: :created
		else
			flash[:error] = 'Error on save notice!'
			render json: { error: 'Error on save notice!' }, status: :unprocessable_entity
		end
	end

	private

	def add_ckeditor
		javascript_links(['https://cdn.ckeditor.com/ckeditor5/29.2.0/classic/ckeditor.js'])
	end

	def set_notice
		@notice = Notice.find_by(id: params[:id])
	end

	def notice_params
		params[:notice].permit(:title, :title_es, :description, :description_es, :notice_type)
	end
end
