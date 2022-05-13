class Account < ApplicationRecord
	has_many :characters, foreign_key: 'accountid'
end