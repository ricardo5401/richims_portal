# frozen_string_literal: true

module Paypal
	module Auth
		# @return [Object]
		def fetch_credentials
			return nil unless ENV['PAYPAL_URI']

			url = "#{ENV['PAYPAL_URI']}/v1/oauth2/token"
			result = HTTParty.post(
				url,
				headers: {
					'Accept' => 'application/json',
					'Content-Type' => 'application/json'
				},
				basic_auth: {
					username: ENV['PAYPAL_CLIENT_ID'],
					password: ENV['PAYPAL_SECRET']
				},
				body: {
					grant_type: 'client_credentials'
				}
			)
			JSON.parse(result.response.body, object_class: OpenStruct)
		end
	end
end
