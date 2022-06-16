class Notice < ApplicationRecord
	enum status: %i[inactive active]
end