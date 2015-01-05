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
    # Customer.validates :phone, uniqueness: true, :length => { :in => 6..12 }, :format => { :with => /\A[0-9\+\-\/\(\)]+\Z/i, :message => "is not valid" }
    # Customer.validates :phonecode, presence: true
    # Customer.validates :birthdate, presence: true
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
