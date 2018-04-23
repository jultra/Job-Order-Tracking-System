Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#login'
  get '/login' => 'users#login'
  get '/index' => 'users#index'
  get '/signup' => 'users#sign_up'
  get '/request_form' => 'job_orders#request_form'
  post '/request_form' => 'job_orders#request_form'
  get '/pending_requests' => 'job_orders#pending_requests'
  get '/ongoing_jobs' => 'job_orders#ongoing_jobs'
  get '/finished_jobs' => 'job_orders#finished_jobs'
  get '/trash' => 'job_orders#trash'
  post '/pending_requests' => 'job_orders#pending_requests'
end
