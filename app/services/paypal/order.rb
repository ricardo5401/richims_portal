# frozen_string_literal: true
#
module Paypal
	class Order < Paypal::Base
		def fetch(order_id)
			url = "#{@config.uri}/v2/checkout/orders/#{order_id}"
			get_request(url)
		rescue StandardError
			Rails.logger.error 'fetch order return no content'
			nil
		end
	end
end