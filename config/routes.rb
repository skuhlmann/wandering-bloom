Rails.application.routes.draw do
  root 'bloom#index'

  namespace :api do
    namespace :v1 do
      get '/bloom/:time', to: 'bloom#show'
    end
  end
end
