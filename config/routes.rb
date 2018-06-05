Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#login'
  get '/login' => 'users#login'
  get '/index' => 'users#index'
  get '/signup' => 'users#sign_up'
  get '/job_orders/list_pending_requests' => 'job_orders#list_pending_requests'
  get '/job_orders/list_pending_approval' => 'job_orders#list_pending_approval'
  get '/job_orders/approve_job_order/:id' => 'job_orders#approve_job_order', as: 'approve_job_order'
  get '/job_orders/reject_job_order/:id' => 'job_orders#reject_job_order', as: 'reject_job_order'
  resources :job_orders
  resources :users
end
