Rails.application.routes.draw do

  namespace :one_ai, defaults: { business: 'one_ai' } do
    namespace :my, defaults: { namespace: 'my' } do
      resources :chats do
        resources :messages
      end
    end

    namespace :admin, defaults: { namespace: 'admin' } do
      controller :home do
        get :index
      end
      resources :apps do
        resources :files
      end
      resources :chats do
        resources :messages
      end
    end

    namespace :panel, defaults: { namespace: 'panel' } do
      root 'home#index'
      controller :home do
        get :index
      end
      resources :apps do
        resources :app_models
        resources :files
      end
      resources :roles
      resources :systems
    end
  end

end
