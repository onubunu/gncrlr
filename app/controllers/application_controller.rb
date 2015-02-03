class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #raise sessions.to_yaml
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  if Employee.count >= 1
    before_filter :authorize
  end 

  delegate :allow?, to: :current_permission
  helper_method :allow?

  protected

  def current_permission
   @current_permission ||= Permission.new(current_employee, current_customer)
  end

  def authorize
    if !current_permission.allow?(params[:controller], params[:action])
      #redirect_to root_url, alert: "Not authorized."
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def configure_devise_permitted_parameters
    registration_params = [:newsletter, :created_by_employee, :birthdate, :title, :phonecode, :phone, :prename, :surname, :email, :password, :password_confirmation, :admin, :head_hr, :head_sales, :staff_hr, :staff_sales, :confirmed_at]

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

end