Rails.application.routes.draw do

  namespace :kimi, defaults: { business: 'kimi' } do
    namespace :admin, defaults: { namespace: 'admin' } do
      resources :apps do
        resources :files
      end
    end
  end

end
