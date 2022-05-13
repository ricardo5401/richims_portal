module FlashHelper
	def flash_class(level)
		case level
		when 'notice' then 'bg-blue-100 border border-blue-400 text-blue-700'
		when 'success' then 'bg-teal-100 border border-teal-400 text-teal-700'
		when 'error' then 'bg-red-100 border border-red-400 text-red-700'
		when 'warning' then 'bg-orange-100 border border-orange-400 text-orange-700'
		end
	end
	def flash_color(level)
		case level
		when 'notice' then 'text-blue-700'
		when 'success' then ' text-teal-700'
		when 'error' then 'text-red-700'
		when 'warning' then 'text-orange-700'
		end
	end
end