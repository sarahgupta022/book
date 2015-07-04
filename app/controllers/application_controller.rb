class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 
   before_filter :configure_permitted_parameters, if: :devise_controller?
   skip_before_filter :verify_authenticity_token, :only => [:set_status]
   
 rescue_from ActiveRecord::RecordNotFound, with: :render_404

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:email, :password, :Password_confirmation, :remember_me, :user_id, :first_name, :last_name,  :profile_name] #add or remove parameters as needed
   
  end
  def configure_permitted_parameters
    registration_params = [:first_name, :last_name, :profile_name, :email, :password, :password_confirmation, :avatar]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) {
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) {
        |u| u.permit(registration_params)
      }
    end
  end
  
  
  private
  def render_permission_error
    render file: 'public/permission_error', status: :error, layout: false
  end
  
  def render_404
    render file: 'public/404', status: :not_found
  end
 

end
