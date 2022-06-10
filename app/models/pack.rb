class Pack < ApplicationRecord
	has_many :pack_items
	enum status: %i[inactive active]

	def codes
		Nxcode.where(pack_id: id)
	end
end