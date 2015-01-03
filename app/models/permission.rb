class Permission < Struct.new(:employee, :customer)
  def allow?(controller, action)
    #####
    return true if controller == "dashboard_customer"
    return true if controller == "customers/registrations" && action.in?(%w[ new create ])
    return true if controller == "customers/sessions" && action.in?(%w[ new create destroy ])   
    return true if controller == "customers/passwords" 
    return true if controller == "customers/confirmations" 
    return true if controller == "dashboard_employee"
    return true if controller == "employees/sessions" && action.in?(%w[ new create destroy ]) && Employee.count >= 1
    return true if controller == "employees/registrations" && action.in?(%w[ new create ]) && Employee.count == 0
    return true if controller == "employees/passwords" 
    return true if controller == "employees/confirmations" && Employee.count == 1

    #####
    if customer
      return true if controller == "customers/registrations" && action.in?(%w[ edit update ]) if !employee
      return true if employee.admin?
    end

    #####
    if employee.manager?
      return true if controller == "customers/registrations" && action.in?(%w[ edit update ]) if !employee

      return true if controller == "employees" && action.in?(%w[ index show ])

      return true if controller == "employees/registrations" && action.in?(%w[ new create edit update ]) 
      return true if employee.admin?
    end
    
    #####
    if employee.admin?
      return true if controller == "customers" && action.in?(%w[ show index edit update new create destroy ])
      return true if controller == "employees" && action.in?(%w[ show index edit update new create destroy ])
      # return true if controller == "customers" && action.in?(%w[ show index edit update new create destroy ])
      # #sign_up(create new user):
      # return true if controller == "employees/registrations" && action.in?(%w[ show index edit update new create destroy ])
      # return true if controller == "employees" && action.in?(%w[ show index edit update new create destroy ])
      # return true if controller == "customers/sessions"
    end
     false
  end
end