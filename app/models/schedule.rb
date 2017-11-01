class Schedule < ApplicationRecord
	belongs_to :user_sell, class_name: "User"
end
