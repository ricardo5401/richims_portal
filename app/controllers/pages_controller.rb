class PagesController < ApplicationController
	def index
		@notices = Notice.where(status: 'active')
		                 .order(id: :desc)
		                 .paginate(page: 1, per_page: 5)
	end

	def downloads
	end

	def vote
	end

	def launcher
		@notices = Notice.where(status: 'active')
		                 .order(id: :desc)
		                 .paginate(page: 1, per_page: 5)
	end
end
