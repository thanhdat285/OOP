class Film < ApplicationRecord
	validates :name, presence: true
end
