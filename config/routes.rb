Rails.application.routes.draw do
  # STEP 1: A ROUTE triggers a controller action
  # verb "/urls" => "namespace/controllers#action"
  get '/jobs' => 'jobs#index'
  get '/jobs/new' => 'jobs#new'
  get '/pages' => 'pages#index'
  get '/home' => 'pages#show'
  post '/users' => 'users#create'
  get '/signup' => 'users#new'
end
