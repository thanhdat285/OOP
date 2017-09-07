module ApplicationHelper
  def current_user
    return nil unless session[:user].present?
    @current_user ||= User.find_by(id: session[:user]["id"])
  end
end
