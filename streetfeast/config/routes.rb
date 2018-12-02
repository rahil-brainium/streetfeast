StreetFeast::Application.routes.draw do
  get "blog/create"
  get "management/show_users"
  get "home/index"
  get "home/dashboard"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'home#dummy_homepage'
  # root 'home#under_construction'
  root 'home#index'

  get 'test_email' => 'application#test_email'

  get 'home/blacklist' => 'home#blacklist'

  post 'home/blacklist' => 'home#blacklist'

  get 'home/analytics' => 'home#analytics'

  post 'home/analytics' => 'home#analytics'

  get 'home/undo_blacklist' => 'home#undo_blacklist'

  post 'home/undo_blacklist' => 'home#undo_blacklist'
  
  get '/users' => 'user#index'

  get 'home/dashboard' => 'home#dashboard', as: :dashboard

  get 'home/dashboard_user' => 'home#dashboard_user'

  get 'user/:id/edit' => 'user#edit'

  get 'home/new_sms' => 'home#new_sms'

  post 'home/send_sms' => 'home#send_sms'

  patch 'user/:id/update' => 'user#update'

  post 'blog/create' => 'blog#create'

  post 'blog/create_blog_user' => 'blog#create_blog_user'

  get 'blog/new' => 'blog#new'

  get '/blogs' => 'blog#index'

  get 'blog/:id/edit' => 'blog#edit'

  get 'blog/:id' => 'blog#show'

  patch 'blog/update/:id' => 'blog#update'

  post 'blog/add_picture_to_blog' => 'blog#add_picture_to_blog'

  get 'user/show/:id' => 'user#show'

  patch 'user/update/:id' => 'user#update'

  delete 'user/photo_remove/:id' => "user#photo_remove"

  patch 'blog/update_blog_user/:id' => 'blog#update_blog_user'
  
  get 'restaurant/new/:id' => 'restaurant#new'

  post 'restaurant/create' => 'restaurant#create'

  get 'restaurant/:id' => 'restaurant#show'

  get 'restaurant/show_for_user/:id' => 'restaurant#show_for_user'

  get 'restaurant/pic/show/:id' => 'restaurant#show_pic'

  get 'like/pic_like/:id' => 'like#pic_like'

  get 'restaurant/address/:id' => 'restaurant#address'

  patch 'restaurant/update/:id' => 'restaurant#update'
  
  get 'menu/:id' => "menu#show"

  get "/restaurants" => "restaurant#index"
  get 'support_ticket/new' => "supportticket#new"

  post 'support_ticket/create' => 'supportticket#create'

  get '/support_tickets' => 'supportticket#index'


  get '/support_ticket/show/:id' => 'supportticket#show'

  get 'support_ticket/resolve' => "supportticket#resolve"

  get 'subscription/new' => 'subscription#new'

  post 'menu/create/:id' => 'menu#create'

  get '/menu/is_available/:id' => 'menu#is_available'

  get '/subscriptions' => 'subscription#index'

  get '/subscriptions/send_newsletter' => 'subscription#send_newsletter'

  post '/menu/edit_price' => 'menu#edit_price'

  get '/feedback/create' => 'feedback#create'

  get "payment/new" => "payment#new"

  post '/payment/create' => 'payment#create'

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
