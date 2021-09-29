class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
    format: {with: VALID_EMAIL_REGEX}
  validates :name, presence: true,
    length: {
      minimum: Settings.validations.digit.length_6,
      maximum: Settings.validations.digit.length_50
    }
  has_secure_password

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost: cost
  end
end
