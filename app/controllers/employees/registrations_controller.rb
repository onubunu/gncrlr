class Employees::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  if Employee.count == 0
    before_filter :authenticate
  else
    #prepend_before_filter :authenticate_scope!, only: [:new, :create, :cancel, :edit, :update, :destroy]
    skip_before_filter :require_no_authentication, only: [:create, :new]
  end 

  # GET /resource/sign_up
  # def new
  #   super
  # end
  def new
    if current_employee.blank? && current_customer.present?
      redirect_to root_path, notice: 'Sign out customer before.' 
    else
      if Employee.count == 0
        #Start: original new-action-prozedur
        build_resource({})
        @validatable = devise_mapping.validatable?
        if @validatable
          @minimum_password_length = resource_class.password_length.min
        end
        yield resource if block_given?
        respond_with self.resource
        #Ende: original new-action-prozedur
      else
        if current_employee.blank? 
          redirect_to new_employee_session_path
        else
          #Start: original new-action-prozedur
          build_resource({})
          @validatable = devise_mapping.validatable?
          if @validatable
            @minimum_password_length = resource_class.password_length.min
          end
          yield resource if block_given?
          respond_with self.resource
          #Ende: original new-action-prozedur
        end
      end
    end
  end

  # POST /resource
  # def create
  #   super
  # end
  def create
    build_resource(sign_up_params)
    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
      set_flash_message :notice, :signed_up if is_flashing_format?
      #sign_up(resource_name, resource)
      sign_up(resource_name, resource) if !employee_signed_in?
      respond_with resource, location: after_sign_up_path_for(resource)
      else
      set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
      expire_data_after_sign_in!
      respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      #set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end
   def destroy
  #   super
   end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected
  protected

  def after_inactive_sign_up_path_for(resource)
    dashboard_employee_path
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["HTTP_AUTH_USERNAME"] && password == ENV["HTTP_AUTH_PASSWORD"]
    end
    warden.custom_failure! if performed?
  end
  
  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
