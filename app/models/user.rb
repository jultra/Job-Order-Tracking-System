class User < ApplicationRecord
  has_many :notifications, foreign_key: :recipient_id
  has_many :job_orders
  has_one :office, required: false
  validates_uniqueness_of :username

  rolify
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end
  # acts_as_authentic do |c|
  #   c.login_field = 'email'
  # end
  acts_as_authentic do |c|
    c.login_field = 'username'
  end

  # def self.find_by_login_or_email(login)
  #   find_by_email(login)
  # end

  def self.find_by_login_or_username(login)
    find_by_username(login)
  end
end
