Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'user_sessions#new'
 get '/signup' => 'users#new'
  post '/register' => 'users#create'
  get '/job_orders/list_pending_requests' => 'job_orders#list_pending_requests'
  get '/job_orders/list_pending_approval' => 'job_orders#list_pending_approval'
  get '/job_orders/approve_job_order/:id' => 'job_orders#approve_job_order', as: 'approve_job_order'
  get '/job_orders/reject_job_order/:id' => 'job_orders#reject_job_order', as: 'reject_job_order'
  resources :job_orders
  resources :users
  resources :user_sessions, only: [:create, :destroy]
  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in
end
