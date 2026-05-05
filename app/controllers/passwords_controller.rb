class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[ edit update ]

  def new
  end

  def create
    if user = User.find_by(email_address: params[:email_address].to_s.strip.downcase)
      user.password_reset_token!
      PasswordsMailer.reset(user, token: user.reset_token).deliver_later
    end

    redirect_to new_session_path, notice: "Se han enviado las instrucciones de restablecimiento si ese correo existe."
  end

  def edit
  end

  def update
    if @user.password_reset_token_expired?
      redirect_to new_password_path, alert: "El enlace ha expirado. Solicita uno nuevo."
      return
    end

    if params[:password].blank?
      flash.now[:alert] = "Debes ingresar una contraseña nueva."
      render :edit, status: :unprocessable_entity
      return
    end

    if @user.update(params.permit(:password, :password_confirmation))
      @user.clear_reset_token
      redirect_to new_session_path, notice: "Tu contraseña se ha actualizado correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature, ActiveRecord::RecordNotFound
      redirect_to new_password_path, alert: "El enlace de restablecimiento no es válido o expiró."
    end
end
