Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'user_sessions#new'
 # get '/login' => 'users#login'
 # get '/index' => 'users#index'
  get '/signup' => 'users#new'
  post '/register' => 'users#create'
  #get '/request_form' => 'job_orders#request_form'
  #post '/request_form' => 'job_orders#request_form'
  #get '/pending_requests' => 'job_orders#pending_requests'
  #get '/ongoing_jobs' => 'job_orders#ongoing_jobs'
  #get '/finished_jobs' => 'job_orders#finished_jobs'
  #get '/trash' => 'job_orders#trash'
  #post '/pending_requests' => 'job_orders#pending_requests'

  resources :users, only: [:new, :create]
  resources :user_sessions, only: [:create, :destroy]
  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in
end
