class Customers::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end
  def new
    if employee_signed_in?
      def Customer.find_for_database_authentication(conditions={})
        find_by(phone: conditions[:phone]) && find_by(surname: conditions[:phonecode]) || find_by(phonecode: conditions[:phonecode])
      end
      Devise.setup do |config|
        config.authentication_keys = [:phone, :phonecode]
      end
    else
      def Customer.find_for_database_authentication(conditions={})
        find_by(email: conditions[:email]) || find_by(phone: conditions[:email])
      end
      Devise.setup do |config|
        config.authentication_keys = [:email] #|| config.authentication_keys = [:phone]
      end
    end
    super
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  def destroy
    signed_out = sign_out :customer
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield if block_given?
    respond_to_on_destroy
  end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
