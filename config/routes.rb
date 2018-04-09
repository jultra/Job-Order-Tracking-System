Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#login'
  get '/login' => 'users#login'
  get '/index' => 'users#index'
  get '/signup' => 'users#sign_up'
  get '/request_form' => 'job_orders#request_form'
end
