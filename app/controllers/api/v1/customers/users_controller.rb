class Api::V1::Customers::UsersController < Api::V1::Customers::BaseController
  skip_before_action :authenticate_request!, only: :create

  def create
    @user = User.new(user_params.merge)
    if @user.save
      render json: {code: 1, message: "Tạo mới tài khoản thành công"}
    else
      render json: {code: 0, message: "Tạo mới tài khoản thất bại"}
    end
  end

  def update
    if @current_user.update_attributes(user_params)
      if params[:avatar].present?
        @current_user.update_attributes(avatar: save_file_with_token("images/avatars/#{@current_user.id}/", 
          params[:avatar]))
      end
      render json: {code: 1, message: "Cập nhật tài khoản thành công"}
    else
      render json: {code: 0, message: @current_user.errors.full_messages}
    end
  end

  def deposit
    if @current_user.deposit(params[:money])
      render json: {code: 1, message: "Gửi tiền vào tài khoản thành công"}
    else
      render json: {code: 0, message: @current_user.errors.full_messages}
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password)
  end
end
