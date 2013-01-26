class UserMailer < ActionMailer::Base
  default from: "no-reply@markholmberg.com"

  def confirmation(user)
    @user = user
    mail(to: user.email, subject: I18n.t("user_mailer.confirmation.subject"))
  end

end
