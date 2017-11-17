class Ticket < ApplicationRecord
  belongs_to :schedule
  belongs_to :user_buy, class_name: "User"
end
