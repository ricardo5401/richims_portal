
module Paypal
	class Item
		attr_accessor :error, :unlock, :client_secret, :account

		def initialize(account, params)
			@account = account
			@order_id = params[:order_id]
			@pack_id = params[:pack_id]
		end

		def generate_code!
			create_unlock
			self
		end

		def success?
			error.nil?
		end

		private

		def invalid_order?
			paypal = Paypal::Order.new
			order = paypal.fetch(@order_id)
			!order.id || order.id != @order_id
		end

		def raise_expected_errors
			fail Errors::InvalidOrderError if invalid_order?
			fail Errors::AlreadyPurchased if Nxcode.exists?(order_id: @order_id.to_s)

			true
		end

		def create_unlock
			raise_expected_errors

			unlock = build_unlock
			self.unlock = unlock
		rescue Errors::InvalidOrderError
			self.error = 'La orden de compra es inválida'
		rescue Errors::AlreadyPurchased
			self.error = 'La orden ya ha sido entregada'
		rescue StandardError => e
			Rails.logger.error [e.message, *e.backtrace].join($INPUT_RECORD_SEPARATOR)
			self.error = 'Error al realizar la compra. Por favor contacta con soporte@udocz.com'
		end

		def build_unlock
			exp = Nxcode.generate_expiration(50)
			code = Nxcode.generate(@pack_id, exp)
			code.order_id = @order_id
			code.account_id = @account.id
			code.save!
			code
		end

	end
end