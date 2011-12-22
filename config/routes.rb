IdeaApp::Application.routes.draw do
 
  resources :idea_commitments

  resources :user_idea_times

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

  devise_for :users, :controllers => { :omniauth_callbacks => 'omniauth_callbacks'}

  get 'home/index'
  root :to => 'home#index'

  match 'home/add_idea', :to => 'home#add_idea',
        :as => :add_idea, :via => 'POST'
  match 'home/process_idea', :to => 'home#process_idea',
        :as => :initial_idea, :via => 'POST'
  match 'home/interest_match', :to => 'home#interest_match',
        :as => :interest_match, :via => 'GET'
  match 'home/authenticated_home', :to => 'home#authenticated_home',
        :as => :authenticated_home, :via => 'GET'
  match 'home/next_ideas_batch_js', :to => 'home#next_ideas_batch_js',
        :as => :next_ideas_batch_js, :via => 'GET'
  match 'home/session_timeout', :to => 'home#session_timeout',
        :as => :session_timeout, :via => 'GET'

  match 'users', :to => 'users#index',
        :as => :users, :via => 'GET'
  match 'users/:id', :to => 'users#show',
        :as => :user, :via => 'GET'
  match 'user/profile', :to => 'users#profile',
        :as => :users_profile, :via => 'GET'
  match 'user/set_view_layout', :to => 'users#set_view_layout',
        :as => :user_set_view_layout, :via => 'POST'

  # route for feedback chat client
  match 'feedback/index', :to => 'feedback#index',
        :as => :feedback, :via => 'GET'

	# route for pusher private / presence channel authentication
	match 'pusher/auth', :to => 'pusher#auth',
				:as => :pusher_auth, :via => 'POST'

  # routes for Ideas
  match 'idea/ideas_chat_user', :to => 'ideas#idea_chat_user',
        :as => :idea_chat_user, :via => 'GET'
  match 'idea/featured_idea_admin', :to => 'ideas#featured_idea_admin',
        :as => :featured_idea_admin, :via => 'GET'
  match 'idea/feature_idea', :to => 'ideas#feature_idea',
        :as => :feature_idea, :via => 'POST'
  match 'idea/new_forum_topic', :to => 'ideas#new_forum_topic',
        :as => :new_forum_topic
  match 'idea/idea_preview', :to => 'ideas#idea_preview',
        :as => :idea_preview, :via => 'GET'
  match 'idea/idea_chat_user_list', :to => 'ideas#idea_chat_user_list',
        :as => :idea_chat_user_list, :via => 'GET'
  match 'idea/idea_kick_user_list', :to => 'ideas#idea_kick_user_list',
        :as => :idea_kick_user_list, :via => 'GET'
  # => Controller actions that handle AJAX button requests from differenet pages
  match 'idea/button_associate_idea_block', :to => 'ideas#button_associate_idea_block',
        :as => :button_associate_idea_block, :via => 'POST'
  match 'idea/button_associate_idea_stream', :to => 'ideas#button_associate_idea_stream',
        :as => :button_associate_idea_stream, :via => 'POST'
  match 'idea/join_idea_from_idea_view', :to => 'ideas#join_idea_from_idea_view',
        :as => :join_idea_from_idea_view, :via => 'POST'

  # routes for Tags
  match 'tag/add_tags_to_idea', :to => 'tags#add_tags_to_idea',
        :as => :add_tags_to_idea, :via => 'POST'
  match 'tag/remove_tag_from_idea', :to => 'tags#remove_tag_from_idea',
        :as => :remove_tag_from_idea, :via => 'POST'
  #    Taken from auto generated path from resources statement 
  #    From: http://stackoverflow.com/questions/4486745/rails-autocomplete-tags-separated-by-commas-using-regex
  #    TODO: make sure this routing is right
  match 'tags/autocomplete_tag_name', :to => 'tags#autocomplete_tag_name',
        :as => :autocomplete_tag_name_tags, :via => 'GET'



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

  # You can have the root of your site routed with 'root'
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with 'rake routes'

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
