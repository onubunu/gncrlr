class Permission < Struct.new(:employee, :customer)
  def allow?(controller, action)
    return true if controller == "products" && action.in?(%w[ show index ])
    
    ##############
  # Zugriff auf Customer-Startseite erlauben:
    return true if controller == "dashboard_customer"
  # Zugriff auf Devise-Customer-Registration anlegen erlauben, wenn kein Employee vorhanden:
    return true if controller == "customers/registrations" && action.in?(%w[ new create ]) if !employee
  # Zugriff auf Devise-Customer-Session anlegen/löschen erlauben:
    return true if controller == "customers/sessions" && action.in?(%w[ new create destroy ])   
  # Zugriff auf Devise-Customer-Password-Vergessen-Funktion erlauben:
    return true if controller == "customers/passwords" 
  # Zugriff auf Devise-Customer-Password-Nicht-Erhalten-Funktion erlauben:
    return true if controller == "customers/confirmations" 
  # Zugriff auf Employee-Startseite erlauben:
    return true if controller == "dashboard_employee"
  # Zugriff auf Devise-Employee-Session anlegen erlauben (nur wenn min. 1 Employee vorhanden):    
    return true if controller == "employees/sessions" && action.in?(%w[ new create destroy ]) && Employee.count >= 1
  # Zugriff auf Devise-Employee-Registration anlegen erlauben (nur wenn kein Employee vorhanden):
    return true if controller == "employees/registrations" && action.in?(%w[ new create ]) && Employee.count == 0
  # Zugriff auf Devise-Employee-Password-Vergessen-Funktion erlauben:
    return true if controller == "employees/passwords" 
  # Zugriff auf Devise-Employee-Password-Nicht-Erhalten-Funktion erlauben (nur für den ersten Employee):
    return true if controller == "employees/confirmations" && Employee.count == 1
  # Employee-Admin hat die selben Rechte
    return true if employee && employee.admin?

    ##############
    if customer
    # Zugriff auf Devise-Customer-Registration bearbeiten erlauben (nur wenn Customer vorhanden ist und kein Employee vorhanden ist):
      return true if controller == "customers/registrations" && action.in?(%w[ edit update ]) if !employee
    # Employee-Admin hat die selben Rechte
      return true if employee && employee.admin?
    end

    ##############
    if employee.manager?
    # Zugriff auf Devise-Customer-Registration anlegen/bearbeiten erlauben:
      return true if controller == "customers/registrations" && action.in?(%w[ new create edit update ])

      #return true if controller == "employees" && action.in?(%w[ index show ])

    # Zugriff auf Devise-Employee-Registration anlegen/bearbeiten erlauben:
      return true if controller == "employees/registrations" && action.in?(%w[ new create edit update ]) 
    # Employee-Admin hat die selben Rechte
      return true if employee.admin?
    end
    
    ##############
    if employee.admin?
      return true if controller == "products" && action.in?(%w[ show index edit update new create destroy ])
      return true if controller == "categories" && action.in?(%w[ show index edit update new create destroy ])
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


# #in arbeit##############################################
# class Permission < Struct.new(:employee, :customer)
#   def allow?(controller, action)
#   #   return true if controller == "products" && action.in?(%w[ show index ])
    
#   #   ##############
#   # Zugriff auf Customer-Startseite erlauben:
#     return true if controller == "dashboard_customer"
#   # # Zugriff auf Devise-Customer-Registration anlegen erlauben, wenn kein Employee vorhanden:
#     return true if controller == "customers/registrations" && action.in?(%w[ new create ])
#   # Zugriff auf Devise-Customer-Session anlegen/löschen erlauben:
#     return true if controller == "customers/sessions" && action.in?(%w[ new create destroy ])  
#   # Zugriff auf Devise-Customer-Password-Vergessen-Funktion erlauben:
#     return true if controller == "customers/passwords" 
#   # Zugriff auf Devise-Customer-Password-Nicht-Erhalten-Funktion erlauben:
#     return true if controller == "customers/confirmations" 
#   # Zugriff auf Employee-Startseite erlauben um Employe anmelden zu können:
#     return true if controller == "dashboard_employee"
#   # Zugriff auf Devise-Employee-Session anlegen erlauben (nur wenn min. 1 Employee vorhanden):    
#     return true if controller == "employees/sessions" && action.in?(%w[ new create destroy ]) && Employee.count >= 1
#   # Zugriff auf Devise-Employee-Registration anlegen erlauben (nur wenn kein Employee vorhanden):
#     return true if controller == "employees/registrations" && action.in?(%w[ new create ]) && Employee.count == 0
#   # Zugriff auf Devise-Employee-Password-Vergessen-Funktion erlauben:
#     return true if controller == "employees/passwords" 
#   # Zugriff auf Devise-Employee-Password-Nicht-Erhalten-Funktion erlauben (nur für den ersten Employee):
#     return true if controller == "employees/confirmations" && Employee.count == 1
#   # Employee-Admin hat die selben Rechte
#     #return true if employee.admin?
#     #return true if employee.manager?

#     ##############
#     if customer
#     # Zugriff auf Devise-Customer-Registration bearbeiten erlauben (nur wenn Customer vorhanden ist und kein Employee vorhanden ist):
#       return true if controller == "customers/registrations" && action.in?(%w[ edit update ]) if !employee
#     # Employee-Admin hat die selben Rechte
#       return true if employee.admin?
#       #return true if employee.manager?
#     end

#     ##############
# #     if employee
# #     # Zugriff für Admin/Manager auf Devise-Customer-Registration anlegen/bearbeiten erlauben:
# #       return true if controller == "customers/registrations" && action.in?(%w[ new create edit update ]) if !employee.admin?

# # return true if controller == "products" && action.in?(%w[ show index edit update new create destroy ]) if !employee.admin?
# # return true if controller == "products" && action.in?(%w[ show index edit update new create destroy ]) if employee.manager? #|| employee.admin?
# #       return true if controller == "employees" && action.in?(%w[ index show ])

# #     # Zugriff auf Devise-Employee-Registration anlegen/bearbeiten erlauben:
# #       return true if controller == "employees/registrations" && action.in?(%w[ new create edit update ]) 
# #     #Employee-Admin hat die selben Rechte
# #       #return true if employee.admin?
# #     end
    
#     ##############
#     #if employee.admin?



#       # return true if controller == "products" && action.in?(%w[ show index edit update new create destroy ])
#       # return true if controller == "categories" && action.in?(%w[ show index edit update new create destroy ])
#       # return true if controller == "customers" && action.in?(%w[ show index edit update new create destroy ])
#       # return true if controller == "employees" && action.in?(%w[ show index edit update new create destroy ])



#       # return true if controller == "customers" && action.in?(%w[ show index edit update new create destroy ])
#       # #sign_up(create new user):
#       # return true if controller == "employees/registrations" && action.in?(%w[ show index edit update new create destroy ])
#       # return true if controller == "employees" && action.in?(%w[ show index edit update new create destroy ])
#       # return true if controller == "customers/sessions"
#     #end
#      false
#   end
# end