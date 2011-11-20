IdeaApp::Application.routes.draw do
 
  resources :event_pictures

  resources :pictures

  resources :user_events

  resources :idea_events

  resources :events

  resources :idea_deals

  resources :deals

  resources :admin_messages

  resources :chat_messages

  resources :friendships

  resources :user_ideas

  resources :ideas

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks"}

  get "home/index"
  root :to => "home#index"

  match "home/add_idea", :to => "home#add_idea",
        :as => :add_idea, :via => "POST"
  match "home/add_idea_id", :to => "home#add_idea_id",
        :as => :add_idea_id, :via => "POST"
  match "home/process_idea", :to => "home#process_idea",
        :as => :initial_idea, :via => "POST"
  match "home/authenticated_home", :to => "home#authenticated_home",
        :as => :authenticated_home, :via => "GET"
  match "home/next_ideas_batch_js", :to => "home#next_ideas_batch_js",
        :as => :next_ideas_batch_js, :via => "GET"

  match "users", :to => "users#index",
        :as => :users, :via => "GET"
  match "users/:id", :to => "users#show",
        :as => :user, :via => "GET"
  match "user/profile", :to => "users#profile",
        :as => :users_profile, :via => "GET"
  match "user/set_view_layout", :to => "users#set_view_layout",
        :as => :user_set_view_layout, :via => "POST"

  # route for feedback chat client
  match "feedback/index", :to => "feedback#index",
        :as => :feedback, :via => "GET"

	# route for pusher private / presence channel authentication
	match "pusher/auth", :to => "pusher#auth",
				:as => :pusher_auth, :via => "POST"

  match "idea/ideas_chat_user", :to => "ideas#idea_chat_user",
        :as => :idea_chat_user, :via => "GET"
  match "idea/featured_idea_admin", :to => "ideas#featured_idea_admin",
        :as => :featured_idea_admin, :via => "GET"
  match "idea/feature_idea", :to => "ideas#feature_idea",
        :as => :feature_idea, :via => 'POST'

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
  # match ':controller(/:action(/:id(.:format)))'
end
