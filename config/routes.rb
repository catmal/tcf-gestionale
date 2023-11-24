Rails.application.routes.draw do
  resources :items
  resources :bill_of_material_lines
  resources :bill_of_materials do
    post :import, on: :collection
    get 'components'
    get 'groups'
  end
  get 'components_csv', action: :components, controller: 'bill_of_materials'
  get 'groups_csv', action: :groups, controller: 'bill_of_materials'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'bill_of_materials#index'
end
