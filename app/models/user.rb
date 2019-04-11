class User < ApplicationRecord
  has_many :job_orders
  has_one :office, required: false

  rolify
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end
  acts_as_authentic do |c|
    c.login_field = 'email'
  end

  def self.find_by_login_or_email(login)
    find_by_email(login)
  end
end
