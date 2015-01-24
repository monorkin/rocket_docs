Interdasting::Engine.routes.draw do
  root 'application#index'
  get 'versions', to: 'application#index', as: 'versions'
  get 'version/:version', to: 'application#show', as: 'version'
end
