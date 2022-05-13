class Account < ApplicationRecord
	has_many :characters, foreign_key: 'accountid'

	def valid_password?(suggested_password)
		Digest::SHA2.new(512).hexdigest(suggested_password + salt) ||
			Digest::SHA1.hexdigest(password) == suggested_password
	end
end