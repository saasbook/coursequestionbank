Coursequestionbank::Application.routes.draw do

  root :to => 'problems#home'

  get  'auth/:provider/callback' => 'sessions#create'
  post 'logout' => 'sessions#destroy'
  get  'auth/failure' => 'sessions#failure'
  get 'login' => 'sessions#login', :as => 'login'
  get 'upload' => 'upload#index', :as => 'upload'
  post 'upload' => 'upload#upload', ":as" => 'upload'

  resources :problems
  get 'profile' => 'instructors#show', :as => 'profile'
  get 'add_problem' => 'problems#add_to_collection', :as => 'add_problem'
  get 'remove_problem' => 'problems#remove_from_collection'
  post 'problems/:id/add_tags' => 'problems#add_tags', :as => 'problem_add_tags'
  resources :collections
  get 'mark_as_current' => 'instructors#mark_as_current'
  get 'admin' => 'instructors#show_unauthorized', :as => 'admin'
  get 'admin/:permission/:id' => 'instructors#authorize', :as => 'authorize'
  get 'admin/add/to/whitelist' => 'instructors#add_to_whitelist', :as => 'whitelist'
  get 'export' => 'collections#export'
  get 'finalize_upload' => 'collections#finalize_upload'
  post 'update_all' => 'collections#update_all'
  post 'update_multiple_tags' => 'collections#update_multiple_tags'
  # match 'checked_problems' => 'collections#checked_problems'


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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
