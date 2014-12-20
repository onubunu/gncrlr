class Employees::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end
  def new
    if current_customer.present?
      redirect_to root_path, notice: 'Sign out customer before.' 
    else
      if Employee.count == 0
        redirect_to new_employee_registration_path
      else
        #Start: original new-action-prozedur
        self.resource = resource_class.new(sign_in_params)
        clean_up_passwords(resource)
        yield resource if block_given?
        respond_with(resource, serialize_options(resource))
        #Ende: original new-action-prozedur
      end
    end
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end
  def create
    sign_out :customer
    super
  end
  
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
