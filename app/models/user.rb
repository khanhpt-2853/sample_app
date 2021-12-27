class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :downcase_email

  validates :name, presence: true, length: {minimum: Settings.length.digit_5}
  validates :email, presence: true, uniqueness: true,
            length: {maximum: Settings.length.digit_255},
            format: {with: Settings.regex.email}
  validates :password, length: {minimum: Settings.length.digit_5},
            allow_nil: true
  has_secure_password

  scope :order_by_name, ->{order :name}

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def forget
    update_column :remember_digest, nil
  end

  def authenticated? remember_token
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  private

  def downcase_email
    email.downcase!
  end
end
