# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  attr_accessor :remember_token, :activation_token

  validates :username, presence: true,
                       length: { minimum: 3, maximum: 20 },
                       uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /.@./
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true,
                       length: { minimum: 12 },
                       allow_nil: true

  before_create :create_activation_digest
  before_save :downcase_email

  # Remembers a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest
  def authenticated?(attr, token)
    digest = send("#{attr}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  private

  # Converts email to all lower-case
  def downcase_email
    email.downcase!
  end

  # Creates and assigns the activation token and digest
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
