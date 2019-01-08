Rails.application.routes.draw do
  # STEP 1: A ROUTE triggers a controller action
  # verb "/urls" => "namespace/controllers#action"
  get '/jobs' => 'jobs#jobs_near_me' #index
  get '/jobs/new' => 'jobs#new'
  get '/jobs/:id' => 'jobs#show'
  post '/jobs' => 'jobs#create'
  patch '/jobs/:id' => 'jobs#update'
  get '/my_jobs' => 'jobs#my_jobs'

  # consumer profile info
  resources :consumers, except: [:new, :edit]

  # provider profile info
  resources :providers, except: [:new, :edit]

  # consumer sessions login/logout
  post '/consumer_login' => 'consumer_sessions#create'
  delete '/consumer_logout' => 'consumer_sessions#destroy'

  # provider sessions login/logout
  post '/provider_login' => 'provider_sessions#create'
  delete '/provider_logout' => 'provider_sessions#destroy'
end
