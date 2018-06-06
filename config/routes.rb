Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#login'
  get '/login' => 'users#login'
  get '/index' => 'users#index'
  get '/signup' => 'users#sign_up'
  get '/job_orders/list_pending_requests' => 'job_orders#list_pending_requests'
  get '/job_orders/list_pending_adviser_approval' => 'job_orders#list_pending_adviser_approval', as: 'list_pending_adviser_approval'
  get '/job_orders/list_pending_admin_approval' => 'job_orders#list_pending_admin_approval', as: 'list_pending_admin_approval'
  get '/job_orders/admin_approval/:id' => 'job_orders#admin_approval', as: 'admin_approval'
  get '/job_orders/adviser_approval/:id' => 'job_orders#adviser_approval', as: 'adviser_approval'
  get '/job_orders/adviser_approve_job_order/:id' => 'job_orders#adviser_approve_job_order', as: 'adviser_approve_job_order'
  get '/job_orders/admin_approve_job_order/:id' => 'job_orders#admin_approve_job_order', as: 'admin_approve_job_order'
  get '/job_orders/adviser_reject_job_order/:id' => 'job_orders#adviser_reject_job_order', as: 'adviser_reject_job_order'
  get '/job_orders/admin_reject_job_order/:id' => 'job_orders#admin_reject_job_order', as: 'admin_reject_job_order'
  resources :job_orders
  resources :users
end
