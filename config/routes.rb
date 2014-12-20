Rails.application.routes.draw do

  root :to => 'dashboard_customer#index'

  get 'dashboard_employee' => 'dashboard_employee#index'

  #devise_for :employees
  devise_for :employees, controllers: { sessions: "employees/sessions", registrations: "employees/registrations", confirmations: "employees/confirmations", passwords: "employees/passwords" } 

  #devise_for :customers
  devise_for :customers, controllers: { sessions: "customers/sessions", registrations: "customers/registrations", confirmations: "customers/confirmations", passwords: "customers/passwords" }
  
  authenticated :employee do
    devise_scope :employee do
      root to: "start_employee#index", :as => "start_employee/index"
    end
  end
  unauthenticated do
    #devise_scope :customer do
     root :to => 'start_customer#index'
    #end
  end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
