if Rails.env.development?
  class MailPreview < MailView

    # User confirmation email
    def confirmation
      @user = User.last
      @user.confirm_token = "12345"
      mail = UserMailer.confirmation(@user)
    end

    # User resetting their password
    def reset_password
      @user = User.last
      @user.password_reset_token = "12345"
      @user.password_reset_sent_at = Time.zone.now
      mail = UserMailer.reset_password(@user)
    end

  end
end