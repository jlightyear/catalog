class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def confirm_logged_in
  	unless session[:admin_id]
  		flash[:notice] = "Por favor log in."
  		redirect_to(access_login_path)
  		return false #stop, halts the before_action
  	else
  		return true
  	end
  end

  def common_variable_sections
    @sections = Section.sorted
  end

end
