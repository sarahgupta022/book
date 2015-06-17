class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 
   before_filter :configure_permitted_parameters, if: :devise_controller?
   skip_before_filter :verify_authenticity_token, :only => [:set_status]

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:email, :password, :Password_confirmation, :remember_me, :user_id, :first_name, :last_name,  :profile_name] #add or remove parameters as needed
   
  end
  
  private
  def render_permission_error
    render file: 'public/permission_error', status: :error, layout: false
  end
 

end
