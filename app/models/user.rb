class User < ActiveRecord::Base
  include Gravtastic

  has_secure_password
  has_gravatar

  has_many :permissions
  has_many :roles, through: :permissions
  has_many :articles

  # Comments that belong to my articles, whether I was the comment author or not
  has_many :comments
  has_many :comments, through: :articles

  # Comments that I made on ANY article
  has_many :my_comments, class_name: 'Comment', foreign_key: :user_id

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

  def send_password_reset_email
    self.generate_password_reset_token
    UserMailer.reset_password(self).deliver unless password_reset_expired?
  end

  def generate_password_reset_token
    generate_token(:password_reset_token)
    save!
  end

  def password_reset_expired?
    # Don't send the email if the token or time is blank
    return true if password_reset_token.blank?
    return true if password_reset_sent_at.blank?

    # Don't send the email if it's been 2 hours since they requested it
    return true if password_reset_sent_at < (Time.zone.now - 2.hours)

    # Don't send to example.com
    return true if /\w@(example)\.com/.match(self.email)
  end

  def destroy_password_reset
    # they used up their password reset request
    self.update_attributes(password_reset_sent_at: nil, password_reset_token: nil)
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
