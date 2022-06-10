class Nxcode < ApplicationRecord
	self.table_name = 'nxcode'
	belongs_to :pack

	def pack_items
		PackItem.where(pack_id: pack_id)
	end

	class << self
		def generate_expiration(days = 10)
			((DateTime.now + days.days).to_f * 1000).to_i
		end

		def generate(pack_id, exp = generate_expiration)
			self.create(
				code: SecureRandom.hex(6).upcase,
				expiration: exp,
				pack_id: pack_id
			)
		end
	end
end