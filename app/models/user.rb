class User < ActiveRecord::Base
  has_secure_password

  has_many :permissions
  has_many :roles, through: :permissions
  has_many :articles
  has_many :comments
  has_many :comments, through: :articles

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
  before_create :generate_confirm_token
  before_create :default_to_commenter
  after_create :send_confirmation_email

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def name
    "#{first_name.presence} #{last_name.presence}"
  end

  def is?(role_key)
    roles.get(role_key).present?
  end

  def confirmed?
    # confirming the account nils the confirm_token and sets confirmed_at
    confirmed_at.present? && (confirm_token == nil)
  end

  def confirm_account
    self.update_attributes(confirmed_at: Time.zone.now, confirm_token: nil)
  end

  # Not private so we can call it again to resend the confirmation
  def send_confirmation_email
    return false if /\w@(example)\.com/.match(self.email)
    UserMailer.confirmation(self).deliver unless confirmed?
  end

  private

  def generate_auth_token
    generate_token(:auth_token)
  end

  def generate_confirm_token
    generate_token(:confirm_token)
  end

  def default_to_commenter
    role = Role.find_by_key(:commenter)
    if role && self.roles.empty?
      self.permissions.build(role_id: role.id)
    end
  end

end
