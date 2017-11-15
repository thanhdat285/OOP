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

  private
  def check_confirmation
    self.password.eql?(self.password_confirmation)
  end

  def encrypt_password
    if self.password_changed?
      self.password = Digest::SHA1.hexdigest(Settings.code + self.password + self.email)
    end
  end
end
