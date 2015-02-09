# class Permission < Struct.new(:employee, :customer)
#   def allow?(controller, action)
#     return true if controller == "products" && action.in?(%w[ show index ])
    
#     ##############
#   # Zugriff auf Customer-Startseite erlauben:
#     return true if controller == "dashboard_customer"
#   # Zugriff auf Devise-Customer-Registration anlegen erlauben, wenn kein Employee vorhanden:
#     return true if controller == "customers/registrations" && action.in?(%w[ new create ]) if !employee
#   # Zugriff auf Devise-Customer-Session anlegen/löschen erlauben:
#     return true if controller == "customers/sessions" && action.in?(%w[ new create destroy ])   
#   # Zugriff auf Devise-Customer-Password-Vergessen-Funktion erlauben:
#     return true if controller == "customers/passwords" 
#   # Zugriff auf Devise-Customer-Password-Nicht-Erhalten-Funktion erlauben:
#     return true if controller == "customers/confirmations" 
#   # Zugriff auf Employee-Startseite erlauben:
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
#     return true if employee && employee.admin?

#     ##############
#     if customer
#     # Zugriff auf Devise-Customer-Registration bearbeiten erlauben (nur wenn Customer vorhanden ist und kein Employee vorhanden ist):
#       return true if controller == "customers/registrations" && action.in?(%w[ edit update ]) if !employee
#     # Employee-Admin hat die selben Rechte
#       return true if employee && employee.admin?
#     end

#     ##############
#     if employee.manager?
#     # Zugriff auf Devise-Customer-Registration anlegen/bearbeiten erlauben:
#       return true if controller == "customers/registrations" && action.in?(%w[ new create edit update ])

#       #return true if controller == "employees" && action.in?(%w[ index show ])

#     # Zugriff auf Devise-Employee-Registration anlegen/bearbeiten erlauben:
#       return true if controller == "employees/registrations" && action.in?(%w[ new create edit update ]) 
#     # Employee-Admin hat die selben Rechte
#       return true if employee.admin?
#     end
    
#     ##############
#     if employee.admin?
#       return true if controller == "products" && action.in?(%w[ show index edit update new create destroy ])
#       return true if controller == "categories" && action.in?(%w[ show index edit update new create destroy ])
#       return true if controller == "customers" && action.in?(%w[ show index edit update new create destroy ])
#       return true if controller == "employees" && action.in?(%w[ show index edit update new create destroy ])
#       # return true if controller == "customers" && action.in?(%w[ show index edit update new create destroy ])
#       # #sign_up(create new user):
#       # return true if controller == "employees/registrations" && action.in?(%w[ show index edit update new create destroy ])
#       # return true if controller == "employees" && action.in?(%w[ show index edit update new create destroy ])
#       # return true if controller == "customers/sessions"
#     end
#      false
#   end
# end


#in arbeit##############################################
class Permission < Struct.new(:employee, :customer)
  def allow?(controller, action)


  #Jeder angemeldete und nichtangemeldete User#############
  # Zugriff auf Produkte anzeigen erlauben:
    return true if controller == "products" && action.in?(%w[ show index ])
  # Zugriff auf Kategorien anzeigen erlauben:
    return true if controller == "categories" && action.in?(%w[ show index edit ])
  # Zugriff auf Customer-Startseite erlauben:
    return true if controller == "dashboard_customer"
  # # Zugriff auf Devise-Customer-Registration anlegen erlauben, wenn kein Employee vorhanden:
    return true if controller == "customers/registrations" && action.in?(%w[ new create ]) if !employee
  # Zugriff auf Devise-Customer-Session anlegen/löschen erlauben, wenn kein Employee vorhanden:
    return true if controller == "customers/sessions" && action.in?(%w[ new create destroy ])  if !employee
  # Zugriff auf Devise-Customer-Password-Vergessen-Funktion erlauben, wenn kein Employee vorhanden:
    return true if controller == "customers/passwords" if !employee
  # Zugriff auf Devise-Customer-Password-Nicht-Erhalten-Funktion erlauben, wenn kein Employee vorhanden:
    return true if controller == "customers/confirmations" if !employee
  # Zugriff auf Employee-Startseite erlauben um Employe anmelden zu können:
    return true if controller == "dashboard_employee"
  # Zugriff auf Devise-Employee-Session anlegen erlauben (nur wenn min. 1 Employee vorhanden):    
    return true if controller == "employees/sessions" && action.in?(%w[ new create destroy ]) if Employee.count >= 1
  # Zugriff auf Devise-Employee-Registration anlegen erlauben (nur wenn kein Employee vorhanden):
    return true if controller == "employees/registrations" && action.in?(%w[ new create ]) if Employee.count == 0
  # Zugriff auf Devise-Employee-Password-Vergessen-Funktion erlauben (nur wenn kein Employee vorhanden):
    return true if controller == "employees/passwords"  if Employee.count >= 1
  # Zugriff auf Devise-Employee-Password-Nicht-Erhalten-Funktion erlauben (nur für den ersten Employee):
    return true if controller == "employees/confirmations" if Employee.count == 1

    #Jeder angemeldete User#############
    if customer
    # Zugriff auf Devise-Customer-Registration bearbeiten erlauben (nur wenn Customer vorhanden ist und kein Employee vorhanden ist):
      return true if controller == "customers/registrations" && action.in?(%w[ edit update ]) if !employee
    end

    #staff_hr#############
    if employee && employee.staff_hr? || employee && employee.head_hr? || employee && employee.manager?

    end

    #head_hr#############
    if employee && employee.head_hr? || employee && employee.manager? 
      return true if controller == "employees" && action.in?(%w[ show index edit update new create destroy ])
      return true if controller == "employees/registrations" && action.in?(%w[ show index edit update new create destroy ])
    end

    #staff_buying#############
    if employee && employee.staff_buying? || employee && employee.head_buying? || employee && employee.manager? 

    end

    #head_buying#############
    if employee && employee.head_buying? || employee && employee.manager? 
      return true if controller == "products" && action.in?(%w[ show index edit update new create destroy ])
      return true if controller == "categories" && action.in?(%w[ show index edit update new create destroy ])
    end

    #staff_sales#############
    if employee && employee.staff_sales? || employee && employee.head_sales? || employee && employee.manager?
    # Zugriff auf Devise-Customer-Registration anlegen/bearbeiten erlauben:
      return true if controller == "customers/registrations" && action.in?(%w[ new create edit update ]) #if !employee.admin?
    # Zugriff auf Devise-Customer-Session anlegen/löschen erlauben:  
      return true if controller == "customers/sessions" && action.in?(%w[ new create destroy ])  #if !employee
    end

    #head_sales#############
    if employee && employee.head_sales? || employee && employee.manager?
    # Zugriff auf Produkte anzeigen/bearbeiten(nur Preis) erlauben:
      return true if controller == "products" && action.in?(%w[ show index edit update ])
    # Vollzugriff auf Customers erlauben 
      return true if controller == "customers" && action.in?(%w[ show index edit update new create destroy ])    
    end

    #admin#############
    # Hat alle Rechte
    return true if employee && employee.admin?


#return true if controller == "products" && action.in?(%w[ show index edit update new create destroy ]) if !employee.admin?
#return true if controller == "products" && action.in?(%w[ show index edit update new create destroy ]) if employee.manager? #|| employee.admin?
      #return true if controller == "employees" && action.in?(%w[ index show ])

    # Zugriff auf Devise-Employee-Registration anlegen/bearbeiten erlauben:
      #return true if controller == "employees/registrations" && action.in?(%w[ new create edit update ]) 
    #Employee-Admin hat die selben Rechte
      #return true if employee.admin?
    
    #manager#############


    ##############
    #if employee.admin?



      # return true if controller == "products" && action.in?(%w[ show index edit update new create destroy ])
      # return true if controller == "categories" && action.in?(%w[ show index edit update new create destroy ])
      # return true if controller == "customers" && action.in?(%w[ show index edit update new create destroy ])
      # return true if controller == "employees" && action.in?(%w[ show index edit update new create destroy ])



      # return true if controller == "customers" && action.in?(%w[ show index edit update new create destroy ])
      # #sign_up(create new user):
      # return true if controller == "employees/registrations" && action.in?(%w[ show index edit update new create destroy ])
      # return true if controller == "employees" && action.in?(%w[ show index edit update new create destroy ])
      # return true if controller == "customers/sessions"
    #end
     false
  end
end