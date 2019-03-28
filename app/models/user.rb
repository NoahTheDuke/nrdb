class User < ApplicationRecord
  validates :username, presence: true,
                       length: { minimum: 3, maximum: 20 },
                       uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /.@./
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true,
                       length: { minimum: 12 }

  before_save do
    email.downcase!
  end

  has_secure_password
end
