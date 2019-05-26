Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'user_sessions#new'

  get '/sign_in', to: 'user_sessions#new', as: :sign_in
  get '/signup' => 'users#signup', as: 'signup_user'
  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  post '/register' => 'users#register', as: 'register_user'

  get '/users/activate/:id' => 'users#activate', as: 'activate_user'
  get '/users/deactivate/:id' => 'users#deactivate', as: 'deactivate_user'

  get '/job_order_tracking_system' => 'job_orders#dashboard', as: 'job_order_tracking_system'
  get '/job_orders/approve_job_order/:id' => 'job_orders#approve_job_order', as: 'approve_job_order'
  get '/job_orders/reject_job_order/:id' => 'job_orders#reject_job_order', as: 'reject_job_order'
  get '/job_orders/start_job_order/:id' => 'job_orders#start_job_order', as: 'start_job_order'
  get '/job_orders/done_job_order/:id' => 'job_orders#done_job_order', as: 'done_job_order'
  get '/job_orders/cancel_job_order/:id' => 'job_orders#cancel_job_order', as: 'cancel_job_order'

  resources :job_orders
  resources :users
  resources :offices
  resources :user_sessions, only: [:create, :destroy]
end
