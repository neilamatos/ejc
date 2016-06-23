Rails.application.routes.draw do
  get 'home' => 'home#index'

  # Resources - Admin
  namespace :admin do
    resources :users
    resources :uos do
      collection do
        get 'update_cidades', as: 'update_cidades'
      end
    end
    resources :roles
  end

  # You can have the root of your site routed with "root"
  devise_for :users
  devise_scope :user do
    root "devise/sessions#new"
  end
end
