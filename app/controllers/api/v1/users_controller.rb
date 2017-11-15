class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create
    @user = User.new(user_params)
    if @user.save
      if params[:avatar].present?
        @user.update_attributes(avatar: save_file_with_token("public/images/avatars/#{@user.id}/", 
          params[:avatar]))
      end
      render json: {code: 1, message: "Tạo mới tài khoản thành công"}
    else
      render json: {code: 0, message: "Tạo mới tài khoản thất bại"}
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password, :role)
  end
end
