class DashboardEmployeeController < ApplicationController

  def index
    if current_customer.present?
      redirect_to root_path, notice: 'Sign out customer before.' 
    else
      if Employee.count == 0
        redirect_to new_employee_registration_path
      else
        if current_employee.blank?
          redirect_to new_employee_session_path
        end
      end
    end
  end
  
end
