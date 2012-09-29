class User < ActiveRecord::Base
  has_secure_password

  validates :password,
    on: :create,
    presence: true
  validates :password_confirmation,
    on: :create,
    presence: true
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: Rails.application.config.email_regex }

  before_create :generate_auth_token

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def name
    "#{first_name.presence} #{last_name.presence}"
  end

  private

  def generate_auth_token
    generate_token(:auth_token)
  end

end
