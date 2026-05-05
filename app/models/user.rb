class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  before_validation :normalize_email

  validates :email_address, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }, if: -> { new_record? || password.present? }

  def self.authenticate_by(email_address:, password:)
    find_by(email_address: email_address.to_s.strip.downcase)&.authenticate(password)
  end

  def generate_reset_token
    signed_id expires_in: 24.hours, purpose: :password_reset
  end

  def password_reset_token!
    token = generate_reset_token
    update!(reset_token: token, reset_sent_at: Time.current)
    token
  end

  def password_reset_token_expired?
    reset_sent_at.nil? || reset_sent_at < 24.hours.ago
  end

  def clear_reset_token
    update!(reset_token: nil, reset_sent_at: nil)
  end

  def self.find_by_password_reset_token!(token)
    user = find_signed!(token, purpose: :password_reset)
    raise ActiveRecord::RecordNotFound unless user.reset_token == token && !user.password_reset_token_expired?
    user
  end

  private

    def normalize_email
      self.email_address = email_address.to_s.strip.downcase if email_address.present?
    end
end
