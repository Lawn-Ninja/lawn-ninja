Rails.application.routes.draw do
  # STEP 1: A ROUTE triggers a controller action
  # verb "/urls" => "namespace/controllers#action"
  get '/jobs' => 'jobs#index'
  get '/jobs/new' => 'jobs#new'
  get '/pages' => 'pages#index'
  get '/home' => 'pages#show'
  get '/signup' => 'users#new'
  post '/sessions' => 'sessions#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/users' => 'users#index'
  post '/users' => 'users#create', as: "new_user"
  get '/users/:id' => 'users#show'
  patch '/users/:id' => 'users#update'
  delete '/users/:id' => 'users#destroy'


end
