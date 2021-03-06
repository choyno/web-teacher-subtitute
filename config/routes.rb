WebBasedTeachersSubstitutionSystem::Application.routes.draw do



  get "confirm_substitutions/index"

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  
  resources :sessions


  resources :teacher_schedules
  resources :substitution_records
  resources :substitutes do
    get :load_teacher_subject, on: :collection
    get :load_sub_teacher_subjects, on: :collection
    get :load_available_teachers, on: :collection
  end
  resources :confirm_substitutions
  resources :generate_reports
  
  resources :remind_substitutes do
    resources :request_details
  end
  
  resources :vouch_requests
  resources :verify_requests
  
  scope '/maintenance' do
    resources :import_schedules, only: [ :index, :create ]
    resources :users
    resources :departments
    resources :teachers
    resources :subjects
    resources :reasons
    resources :daycodes
    resources :sections
    resources :rooms  
    resources :subject_types
  end
  

  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to =>'dashboard#show'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
