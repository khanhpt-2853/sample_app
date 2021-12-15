class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :name, :password, :confirm_password, presence: true
  validates :name, length: {minimum: Settings.length.min_10}
  validates :password, length: {minimum: Settings.length.min_10}
  validates :email, presence: true, uniqueness: true,
    length: {maximum: Settings.length.max_255},
    format: {with: VALID_EMAIL_REGEX}
  has_secure_password
end
