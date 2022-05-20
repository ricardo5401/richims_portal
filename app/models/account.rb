class Account < ApplicationRecord
	has_many :characters, foreign_key: 'accountid'

	def valid_password?(suggested_password)
		BCrypt::Engine.hash_secret(suggested_password, BCrypt::Password.new(password).salt) == password
	end
end