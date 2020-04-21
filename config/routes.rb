require 'sidekiq/web'
Coursequestionbank::Application.routes.draw do
  root :to => 'problems#home'
  mount Sidekiq::Web, at: '/sidekiq'    #needed to view the SideKiq UI 
  match  'auth/:provider/callback' => 'session#create', via: :post
  get 'auth/bypass/:user_id' => 'session#bypass', :as => 'bypass'
  post 'logout' => 'session#destroy'
  get  'auth/failure' => 'session#failure'
  get 'login' => 'session#login', :as => 'login'
  get 'upload' => 'upload#index'
  post 'upload' => 'upload#upload'
  match 'upload/loading' => 'upload#loading', :as => 'loading', :via => [:get,:post]
  get 'upload/fetch' => 'upload#fetch', :as => 'fetch'
  resources :problems
  get 'problems/tags/:tag_names' => 'problems#view_tags', :as => 'view_tags'
  post 'problems/filters' => 'problems#set_filters', :as => 'set_filters'
  post 'problems/:id/tags/add' => 'problems#add_tags', :as => 'add_tags'
  post 'problems/:id/tags/remove' => 'problems#remove_tags', :as => 'remove_tags'
  post 'update_multiple_tags' => 'problems#update_multiple_tags'

  get 'problems/:id/supersede' => 'problems#supersede', :as => 'supersede'

  match 'problems/:id/minorupdate' => 'problems#minorupdate', :as => "minorupdate", :via => [:get,:post]
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
  match 'collections/search/' => 'collections#search', :as => 'search_collection', :via => [:get,:post]
  get 'collections/:id/export' => 'collections#export', :as => 'export'
  get 'collections/:id/preview' => 'collections#preview', :as => 'preview'
  get 'finalize_upload' => 'collections#finalize_upload'
  #post 'collections/filters' => 'collections#set_filters', :as => 'set_filters'
  # post 'update_all' => 'collections#update_all'
  # match 'checked_problems' => 'collections#checked_problems'

end
