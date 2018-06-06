Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'user_sessions#new'
 get '/signup' => 'users#new'
  post '/register' => 'users#create'
  get '/job_orders/list_pending_requests' => 'job_orders#list_pending_requests'
  get '/job_orders/list_pending_adviser_approval' => 'job_orders#list_pending_adviser_approval', as: 'list_pending_adviser_approval'
  get '/job_orders/list_pending_admin_approval' => 'job_orders#list_pending_admin_approval', as: 'list_pending_admin_approval'
  get '/job_orders/admin_approval/:id' => 'job_orders#admin_approval', as: 'admin_approval'
  get '/job_orders/adviser_approval/:id' => 'job_orders#adviser_approval', as: 'adviser_approval'
  get '/job_orders/adviser_approve_job_order/:id' => 'job_orders#adviser_approve_job_order', as: 'adviser_approve_job_order'
  get '/job_orders/admin_approve_job_order/:id' => 'job_orders#admin_approve_job_order', as: 'admin_approve_job_order'
  get '/job_orders/adviser_reject_job_order/:id' => 'job_orders#adviser_reject_job_order', as: 'adviser_reject_job_order'
  get '/job_orders/admin_reject_job_order/:id' => 'job_orders#admin_reject_job_order', as: 'admin_reject_job_order'
  get '/users/approve/:id' => 'users#approve', as: 'approve_user'
  get '/users/reject/:id' => 'users#reject', as: 'reject_user'
  resources :job_orders
  resources :users
  resources :user_sessions, only: [:create, :destroy]
  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in
end
