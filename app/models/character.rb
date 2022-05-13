class Character < ApplicationRecord
	belongs_to :account, foreign_key: 'accountid'
end