Coursequestionbank::Application.routes.draw do

  root :to => 'problems#home'

  match  'auth/:provider/callback' => 'session#create'
  get 'auth/bypass/:user_id' => 'session#bypass', :as => 'bypass'
  post 'logout' => 'session#destroy'
  get  'auth/failure' => 'session#failure'
  get 'login' => 'session#login', :as => 'login'
  get 'upload' => 'upload#index', :as => 'upload'
  post 'upload' => 'upload#upload', ":as" => 'upload'

  resources :problems
  get 'problems/tags/:tag_names' => 'problems#view_tags', :as => 'view_tags'
  post 'problems/filters' => 'problems#set_filters', :as => 'set_filters'
  post 'problems/:id/tags/add' => 'problems#add_tags', :as => 'add_tags'
  post 'problems/:id/tags/remove' => 'problems#remove_tags', :as => 'remove_tags'
  post 'update_multiple_tags' => 'problems#update_multiple_tags'

  get 'problems/:id/supersede' => 'problems#supersede', :as => 'supersede'

  post 'problems/:id/minorupdate' => 'problems#minorupdate', :as => "minorupdate"
  get 'problems/:id/minorupdate' => 'problems#minorupdate', :as => "minorupdate"


  post 'problems/edit_minor' => 'problems#edit_minor', :as => "edit_minor"


  get 'problems/:id/history' => 'problems#view_history', :as => 'problem_history'

  get 'profile' => 'instructors#show', :as => 'profile'
  
  get 'admin' => 'instructors#admin', :as => 'admin'
  post 'admin/instructor' => 'instructors#update_instructor', :as => 'update_instructor'
  # delete 'admin/instructor/:id' => 'instructors#delete_whitelist_entry', :as => 'whitelist_entry'
  # post 'admin/whitelist/toggle' => 'instructors#toggle_whitelist', :as => 'toggle_whitelist'

  resources :studentanswers

  resources :collections
  # post 'collections/:id/problems/add' => 'collections#add_problems'
  # post 'collections/:id/problems/remove' => 'collections#remove_problems'
  # get 'mark_as_current' => 'instructors#mark_as_current'
  post 'collections/search/' => 'collections#search', :as => 'search_collection'
  get 'collections/:id/export' => 'collections#export', :as => 'export'
  get 'collections/:id/preview' => 'collections#preview', :as => 'preview'
  get 'finalize_upload' => 'collections#finalize_upload'
  #post 'collections/filters' => 'collections#set_filters', :as => 'set_filters'
  get 'collections/search/' => 'collections#search', :as => 'search_collection'
  # post 'update_all' => 'collections#update_all'
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
