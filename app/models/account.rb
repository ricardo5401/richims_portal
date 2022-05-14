class Account < ApplicationRecord
	has_many :characters, foreign_key: 'accountid'

	def valid_password?(suggested_password)
		(salt && Digest::SHA2.new(512).hexdigest(suggested_password + salt)) ||
			Digest::SHA1.hexdigest(suggested_password) == password
	end
end