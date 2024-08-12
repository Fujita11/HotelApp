class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

 def show
      @user = current_user
 end

 def edit
 end

 def update
    if @user.update(user_params)
      redirect_to profile_path, notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
 end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:avatar, :name, :bio)
  end
end
