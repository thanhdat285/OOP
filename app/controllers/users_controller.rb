class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Tạo mới tài khoản thành công"
      sign_in @user
    else
      flash[:error] = "Tạo mới tài khoản thất bại"
    end
    redirect_to root_path
  end

  def show
    @user = User.find_by id: params[:id]
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
