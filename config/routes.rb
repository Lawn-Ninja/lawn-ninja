Rails.application.routes.draw do
  get '/pages' => 'pages#index'
  get '/home' => 'pages#show'
  # STEP 1: A ROUTE triggers a controller action
  # verb "/urls" => "namespace/controllers#action"
end
