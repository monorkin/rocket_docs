Rails.application.routes.draw do
  mount RocketDocs::Engine => '/api-doc'

  root 'application#hello'

  namespace :api do
    api version: 1, module: 'v1', allow_prefix: 'v', defaults: { version: 'v1' } do
      resources :people
    end

    api version: 2, module: 'v2', allow_prefix: 'v', defaults: { version: 'v2' } do
      resources :people
      resources :posts
    end
  end

  api version: 3..4, module: 'v3', allow_prefix: 'v', defaults: { version: 'v3' } do
    resources :people
    resources :posts
  end

end
