Rails.application.routes.draw do

  namespace :one_ai, defaults: { business: 'one_ai' } do
    namespace :my, defaults: { namespace: 'my' } do
      resources :chats do
        resources :messages
      end
    end

    namespace :admin, defaults: { namespace: 'admin' } do
      resources :apps do
        resources :files
      end
    end

    namespace :panel, defaults: { namespace: 'panel' } do
      resources :apps do
        resources :files
      end
      resources :roles
    end
  end

end
