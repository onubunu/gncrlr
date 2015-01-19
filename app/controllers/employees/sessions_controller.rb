class Employees::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end
  def new
    if current_employee.blank? && current_customer.present?
      redirect_to root_path, notice: 'Sign out customer before.' 
    else
      if Employee.count == 0
        redirect_to new_employee_registration_path
      else
        super
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
  def destroy
      def Customer.find_for_database_authentication(conditions={})
        find_by(email: conditions[:email]) || find_by(phone: conditions[:email])
      end
      Devise.setup do |config|
        config.authentication_keys = [:email] #|| config.authentication_keys = [:phone]
      end
      super
  end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
