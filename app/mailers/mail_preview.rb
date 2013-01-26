class MailPreview < MailView

  # User confirmation email
  def confirmation
    @user = User.last
    mail = UserMailer.confirmation(@user)
  end
end