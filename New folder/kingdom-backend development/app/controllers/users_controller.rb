class UsersController < ApplicationController
  before_action :authenticate_user!, :user_authenticated?
  before_action :find_user, only: [:update]

  def prospect; end

  def contacted; end

  def update
    return if @user.blank?

    unless @user.update(user_params)
      flash[:error] = @user.errors.full_messages
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def user_params
    params.require(:user).permit(:zoom_link)
  end

  def find_user
    @user = User.find_by id: params[:id]
  end
end
