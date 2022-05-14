class Character < ApplicationRecord
	belongs_to :account, foreign_key: 'accountid'

	def job_name
		I18n.t "jobs.#{job}"
	end
end