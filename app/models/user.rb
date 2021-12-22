class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true, length: {minimum: Settings.length.min_10}
  validates :email, presence: true, uniqueness: true,
            length: {maximum: Settings.length.max_255},
            format: {with: Settings.regex.email}
  validates :password, length: {minimum: Settings.length.min_10}
  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
