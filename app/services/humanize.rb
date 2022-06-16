# frozen_string_literal: true

class Humanize
	class << self
		def counter(number)
			require 'si'
			number.si.gsub('.00', '').gsub('.0k', 'k').gsub('.0M', 'M').gsub('.0B', 'B')
		end

		def counter_with_units(number, single = '', plural = '')
			return nil if number < 1

			unit = number < 2 ? single : plural
			"#{counter(number)} #{unit}".strip
		end

		def counter_with_units_and_zero(number, single = '', plural = '')
			return nil if number < 0

			unit = number == 1 ? single : plural # zero or 2 +
			"#{counter(number)} #{unit}".strip
		end
	end
end
