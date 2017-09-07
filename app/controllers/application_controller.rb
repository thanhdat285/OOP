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
end
