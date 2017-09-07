class SessionsController < ApplicationController
  def create
    email = params[:sign_in][:email]
    password = params[:sign_in][:password]
    @user = User.find_by(email: email)
    if @user.nil?
      flash[:error] = "Tài khoản không tồn tại"
      return redirect_to root_path
    end
    if @user.authenticate!(password)
      sign_in @user
      flash[:success] = "Đăng nhập thành công"
    else
      flash[:error] = "Email hoặc mật khẩu không hợp lệ"
    end
    redirect_to root_path
  end

  def destroy
    session[:user] = nil
    redirect_to root_path
  end
end
