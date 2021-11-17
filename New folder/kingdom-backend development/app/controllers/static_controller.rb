class StaticController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :authenticate_user_status, only: [:index]

  def index; end

  def confirm_phone; end

  def verify_otp
    if session[:otp] == params[:verification_code].to_i
      current_user.update(status: :active)
      redirect_to root_path, notice: 'User signed up successfully'
    else
      flash.now[:notice] = 'Invalid confirmation code!'
      render :confirm_phone
    end
  end

  def after_sign_up
    otp = (SecureRandom.random_number(9e5) + 1e5).to_i
    session[:otp] = otp
    sms = "Confirmation code: #{otp}"
    TwilioClient.new.send_text(current_user.phone_number, sms)
    redirect_to confirm_phone_path
  end

  def authenticate_user_status
    render :confirm_phone if current_user && current_user.status&.to_sym != :active
  end
end
