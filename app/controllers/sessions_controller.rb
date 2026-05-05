class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    email    = params[:email_address].to_s.strip.downcase
    password = params[:password].to_s

    begin
      user = User.authenticate_by(email_address: email, password: password)
    rescue => e
      Rails.logger.error "SessionsController#create error: #{e.class} - #{e.message}"
      user = nil
    end

    if user
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Email o contraseña incorrectos. Verifica tus datos."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end
