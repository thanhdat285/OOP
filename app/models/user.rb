class User < ApplicationRecord
  before_save :check_confirmation
  before_save :encrypt_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}
  validates :balance, numericality: {greater_than_or_equal_to: 0}

  enum role: [:admin, :seller, :company, :customer]

  attr_accessor :password_confirmation

  def authenticate! pass
    self.password == Digest::SHA1.hexdigest(Settings.code + pass + self.email)
  end

  def pay money
    return false if money < 0
    self.update_attributes(balance: self.balance - money)
  end

  def deposit money 
    return false if money < 0
    self.update_attributes(balance: self.balance + money)
  end

  def book_tickets tickets 
    user_bought = false
    tickets.each do |ticket|
      if ticket.user_buy_id.present?
        user_bought = true 
        break
      end
    end
    return false if user_bought

    _total_price = total_price(tickets)
    return false if self.balance < _total_price
    tickets.update_all(user_buy_id: self.id)
    self.pay(_total_price)
    return true
  end

  def history_book_tickets
    return Ticket.select("tickets.*", "films.name as film_name", "films.id as film_id", 
      "locations.id as location_id", "locations.name as location_name",
      "schedules.time_begin", "schedules.time_end", "films.image as film_image").joins(schedule: [:location, :film])
      .where(user_buy_id: self.id).order("tickets.updated_at DESC")
  end

  private
  def check_confirmation
    self.password.eql?(self.password_confirmation)
  end

  def encrypt_password
    if self.password_changed?
      self.password = Digest::SHA1.hexdigest(Settings.code + self.password + self.email)
    end
  end

  private
  def total_price tickets 
    price = 0
    tickets.each do |ticket|
      price += ticket.price 
    end
    return price
  end
end
