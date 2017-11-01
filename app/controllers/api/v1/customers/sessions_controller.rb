class Api::V1::Customers::SessionsController < Api::V1::Customers::BaseController
  skip_before_action :authenticate_request!

  def create
    email = params[:email]
    password = params[:password]
    @user = User.select(:id, :name, :email, :avatar).find_by(email: email)
    return render json: {code: 0, message: "Tài khoản không tồn tại"} if @user.nil?
    if @user.authenticate!(password)
      # sign_in @user
      auth_token = JsonWebToken.encode(user_id: @user.id)
      return render json: {code: 1, message: "Đăng nhập thành công", token: auth_token, data: @user}
    else
      return render json: {code: 0, message: "Email hoặc mật khẩu không hợp lệ"}
    end
  end

  def destroy
    session[:user] = nil
    render json: {code: 1, message: "Đăng xuất thành công"}
  end
end
