class Character < ApplicationRecord
	belongs_to :account, foreign_key: 'accountid'

	def job_name
		I18n.t "jobs.#{job}"
	end

	def picture
		ENV['ASSET_PATH'] ? "#{ENV['ASSET_PATH']}?name=#{name}" : nil
	end
end