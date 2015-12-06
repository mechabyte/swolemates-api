Rails.application.routes.draw do

  jsonapi_resources :muscles
  jsonapi_resources :exercises
  jsonapi_resources :users do
    collection do
      post 'login'
    end
  end

end
