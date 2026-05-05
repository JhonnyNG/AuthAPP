class PasswordsMailer < ApplicationMailer
  def reset(user, token:)
    @user = user
    @reset_token = token
    mail subject: "Restablece tu contraseña", to: user.email_address
  end
end
