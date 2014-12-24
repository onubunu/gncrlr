class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :prename, length: {:minimum => 2}
  validates :surname, length: {:minimum => 2}
  
	def self.find_for_database_authentication(conditions={})
		find_by(phone: conditions[:email]) || find_by(email: conditions[:email])
	end
	 # def self.find_first_by_auth_conditions(conditions={})
  # if current_employee.present?
  #   find_by(prename: conditions[:login])
  # else
  #   find_by(email: conditions[:login])
  # end
  # end

# config/initializers/desvise.rb
# if controller == "employees/sessions"
# Devise.setup do |config|
#   config.authentication_keys = [:prename]
# end
# end

end
