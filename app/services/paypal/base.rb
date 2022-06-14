# frozen_string_literal: true

module Paypal
	class Base
		include Paypal::Auth

		def initialize
			# readable only for extended classes
			_config = {
				uri: ENV['PAYPAL_URI'],
				product_id: ENV['PAYPAL_PRODUCT_ID']
			}
			@config = OpenStruct.new(_config)
			@credentials = fetch_credentials
		end

		def get_request(url)
			result = HTTParty.get(
				url,
				headers: {
					'Accept' => 'application/json',
					'Content-Type' => 'application/json',
					'Authorization' => "Bearer #{@credentials.access_token}"
				}
			)
			JSON.parse(result.response.body, object_class: OpenStruct)
		end

		def post_request(url, params = {})
			result = HTTParty.post(
				url,
				headers: {
					'Accept' => 'application/json',
					'Content-Type' => 'application/json',
					'Authorization' => "Bearer #{@credentials.access_token}"
				},
				body: params.to_json
			)
			body = result.response.body
			return nil if body.blank?

			JSON.parse(body, object_class: OpenStruct)
		end

		def delete_request(url)
			HTTParty.delete(
				url,
				headers: {
					'Accept' => 'application/json',
					'Content-Type' => 'application/json',
					'Authorization' => "Bearer #{@credentials.access_token}"
				}
			)
		end
	end
end
