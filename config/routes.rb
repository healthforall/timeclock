Timeclock::Application.routes.draw do

  #get 'welcome/index'

  resources :employees do
    resources :timesheets do
      get 'current'
      get 'show'
      post 'update'

    end
  end

  root :to => redirect('/login')
  get 'employees/:eid/payperiods/:pid' => 'timesheets#select'
  get 'massexport/payperiods/:pid' => 'timesheets#massExport'
  get 'login' =>'sessions#new'
  get 'auth/:provider/callback' => 'sessions#create'
  post 'logout' => 'sessions#destroy'
  get  'logout' => 'sessions#logout'
  get 'auth/failure'=> 'sessions#failure'

  get 'employees/main/:id' => 'employees#main'

  post 'employees/clockin/:clockingin' => 'employees#clockin'

  get  'fakelogin/:uid' => 'sessions#fakelogin' #this is for capybara testing purposes and should be deleted upon deployment

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

