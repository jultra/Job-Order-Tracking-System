Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#login'
  get '/login' => 'users#login'
  get '/index' => 'users#index'
  get '/signup' => 'users#sign_up'
  get '/job_orders/list_pending_requests' => 'job_orders#list_pending_requests'
  resources :job_orders
  resources :users
end
