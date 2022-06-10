class PackItem < ApplicationRecord
	belongs_to :pack
end

# type:
# 0: Mesos
# 1: Maple Points
# 2: Nx Prepaid
# 3: Prepaid + Nx Credit
# 4: Nx Credit
# 5: items