# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def reset_password(user, token:)
    @user = user
    @reset_token = token
    mail(to: user.email_address, subject: "Restablecer tu contraseña")
  end
end