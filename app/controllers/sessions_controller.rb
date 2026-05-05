class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
  end

  def create
    email    = params[:email_address].to_s.strip.downcase
    password = params[:password].to_s

    # Primero verificamos si el usuario existe
    existing_user = User.find_by(email_address: email)

    unless existing_user
      return redirect_to new_session_path,
        alert: "No existe ninguna cuenta con ese correo electrónico. ¿Quieres registrarte?"
    end

    # Si existe, intentamos autenticar
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
      redirect_to new_session_path, alert: "Contraseña incorrecta. Inténtalo de nuevo."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end
