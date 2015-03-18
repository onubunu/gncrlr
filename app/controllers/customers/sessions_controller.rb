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
  def create
    ##########################################################################
    # wenn user cart in db existiert
    if customer_cart = Cart.find_by(user_id: current_customer.id)
      
      #alle zum aktuellen cart gehörigen line_items als current_line_items deklarieren
      current_line_items = LineItem.all.where(cart_id: session[:cart_id])  

      #alle zum customer gehörigen line_items als user_line_items deklarieren
      #NÖTIG?????
      customer_line_items = LineItem.all.where(cart_id: customer_cart.id)


      # alle zum customer gehörigen line_items und alle zum aktuellen cart gehörigen line_items einzeln miteinander vergleichen, wenn product_id gleich ist dann quantities des user_line_item mit den quantities des current_line_item addieren und die current_line_item löschen
      current_line_item = LineItem.where(cart_id: session[:cart_id])
      customer_line_item = LineItem.where(cart_id: customer_cart.id)

      ####################
      customer_line_item.each do |customer_line_item|
        active_product = Product.find_by(id: customer_line_item[:product_id])
        if active_product.active == false
          customer_line_item.destroy
          customer_line_item.save!
        end
      end
      ######################

      current_line_item.each do |current_line_item|
        customer_line_item.each do |customer_line_item|


      #   xx = Product.find_by(id: customer_line_item.product_id)
      # xx.delete_all(active: false)

        # xx = Product.find_by(id: customer_line_item.product_id)
        # if xx.active == 0
        #   #xx.active == true
        #         customer_line_item.destroy
        #     customer_line_item.save!
        #   else
        #         #xx.active == true
        #         customer_line_item.destroy
        #     customer_line_item.save!
        #   end

          if customer_line_item.product_id == current_line_item.product_id
            customer_line_item.update(quantity: customer_line_item.quantity + current_line_item.quantity)
            customer_line_item.save!
            current_line_item.destroy
            current_line_item.save!
          end
        end
      end
      
      # dann line_items zum user cart hinzufügen
      current_line_items.update_all(cart_id: customer_cart.id)

      # aktuelle cart anschliessend löschen, wenn vorhanden
      if session[:cart_id].present?
        cart = Cart.find_by(id: session[:cart_id])
        cart.destroy
        cart.save!
      end

      # die user cart in die session laden
      session[:cart_id] = customer_cart.id
    else
      # sonst aktuellen cart die current_user.id zuweisen
      cart = Cart.find_by(id: session[:cart_id])
      cart.update(user_id: current_customer.id)
      cart.save!
    end
 ##########################################################################   
    super
  end


  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  # def destroy
  #   signed_out = sign_out :customer
  #   set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
  #   yield if block_given?
  #   respond_to_on_destroy
  # end
  def destroy
    session[:cart_id] = nil
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
