Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'user_sessions#new'
 get '/signup' => 'users#new'
  post '/register' => 'users#create'
  get '/job_orders/pending_requests' => 'job_orders#pending_requests'
  get '/job_orders/list_pending_approval' => 'job_orders#list_pending_approval'
  get '/job_orders/approve_job_order/:id' => 'job_orders#approve_job_order', as: 'approve_job_order'
  get '/job_orders/reject_job_order/:id' => 'job_orders#reject_job_order', as: 'reject_job_order'
  get '/trash' => 'job_orders#trash'
  get '/finished_jobs' => 'job_orders#finished_jobs'
  get '/ongoing_jobs' => 'job_orders#ongoing_jobs'
  get '/manage_job_orders' => 'job_orders#manage_job_orders'
  get '/jobs/approved' => 'job_orders#approved_job_orders'
  get '/jobs/unapproved' => 'job_orders#unapproved_job_orders'
  get '/jobs/ongoing' => 'job_orders#ongoing_job_orders'
  get '/jobs/finished' => 'job_orders#finished_job_orders'
  get '/jobs/assigned' => 'job_orders#assigned_job_orders'
  get '/jobs/unassigned' => 'job_orders#unassigned_job_orders'
  get '/jobs/pending' => 'job_orders#pending_job_orders'
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
  get '/users/new_update' => 'users#new_update'
  get '/users/active_account' => 'users#show_active_account'
  post '/users/:id' => 'users#update'

  get '/job_orders/live_search' => 'job_orders#live_search', as: 'search'
  get '/job_orders/live_search2' => 'job_orders#live_search2', as: 'search2'
  
  resources :job_orders
  resources :users
  resources :offices
  resources :user_sessions, only: [:create, :destroy]
  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in
end
