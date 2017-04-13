Rails.application.routes.draw do
  root 'bloom#index'

  get '/bloom/:tweets', to: 'bloom#tweets'

  namespace :api do
    namespace :v1 do
      get '/bloom/:time', to: 'bloom#show'
    end
  end
end
