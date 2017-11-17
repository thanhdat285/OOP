class Schedule < ApplicationRecord
	belongs_to :user_sell, class_name: "User"
	belongs_to :film
	belongs_to :room
	belongs_to :location
	has_many :tickets

	validates :film_id, presence: true 
	validates :room_id, presence: true
	validates :location_id, presence: true
end
