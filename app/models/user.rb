class User < ActiveRecord::Base
  has_secure_password

  def authenticated?(remember_token)
  return false if remember_digest.nil?
  BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
