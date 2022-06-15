class Nxcode < ApplicationRecord
	self.table_name = 'nxcode'

	def pack_items
		PackItem.where(pack_id: pack_id)
	end

	def pack
		Pack.find_by(id: pack_id)
	end

	def account
		Account.find_by(id: account_id)
	end

	class << self
		def generate_expiration(days = 10)
			((DateTime.now + days.days).to_f * 1000).to_i
		end

		def generate(pack_id, exp = generate_expiration)
			self.new(
				code: SecureRandom.hex(6).upcase,
				expiration: exp,
				pack_id: pack_id,
				created_at: DateTime.now
			)
		end
	end
end