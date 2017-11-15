class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include ApplicationHelper

  def login_required
    redirect_to root_path unless session[:users]
  end

  # def current_user
  #   return nil unless session[:user].present?
  #   @current_user ||= User.find_by(id: session[:user]["id"])
  # end

  def sign_in user
    session[:user] = {"id" => user.id}
  end

  def authenticate_request!
    token = request.headers['Authorization'].split(' ').last rescue nil
    payload = JsonWebToken.decode(token)
    if payload.nil? || !JsonWebToken.valid_payload(payload.first)
      render json: {:message => "Bạn cần phải đăng nhập trước khi tiếp tục."}, status: 401
      return
    end

    @current_user = User.find_by id: payload.first['user_id']
    raise APIError::Client::Unauthorized unless @current_user
  end

  def save_file_with_token dir, file
    begin 
      FileUtils.mkdir_p("public/#{dir}") unless File.directory?("public/#{dir}")
      extn = File.extname file.original_filename
      name = File.basename(file.original_filename, extn).gsub(/[^A-z0-9]/, "_")
      full_name = name + "_" + SecureRandom.hex(5) + extn
      path = File.join(dir, full_name)
      File.open("public/#{path}", "wb") { |f| f.write file.read }
      return path
    rescue
      return nil
    end
  end
end
