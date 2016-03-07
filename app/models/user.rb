class User < ActiveRecord::Base
  attr_accessor :remember_token
  has_secure_password
  has_many :concerts
  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-c\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length {maximum: 40}, format: {with: VALID_EMAIL_REGEX}

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
  SecureRandom.urlsafe_base64
  end


  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
  return false if remember_digest.nil?
  BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
