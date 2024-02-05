Rails.application.routes.draw do
  resources :companies
  resources :order_lines
  resources :orders
  resources :purchase_orders
  resources :sales_orders

  resources :supplier_order_lines
  resources :supplier_orders
  resources :suppliers
  resources :items
  resources :bill_of_material_lines
  resources :bill_of_materials do
    post :import, on: :collection
    get 'components'
    get 'groups'
    get 'import_purchase_order'
    get 'purchase_order_groups'
  end
  get 'components_csv', action: :components, controller: 'bill_of_materials'
  get 'groups_csv', action: :groups, controller: 'bill_of_materials'
  get 'purchase_order_groups_csv', action: :purchase_order_groups, controller: 'bill_of_materials'
  get 'add_component_to_supplier_order', action: :add_component_to_supplier_order, controller: 'purchase_orders'
  get 'send_supplier_order_email', action: :send_email, controller: 'supplier_orders'
  get 'clear_supplier_order', action: :clear_supplier_order, controller: 'supplier_orders'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'bill_of_materials#index'
end
