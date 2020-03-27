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
    resources :encontros
    resources :pessoas do
      collection do
        get 'limpar_filtros', as: 'limpar_filtros'
        match 'search' => 'styles#index', :via => [:get, :post], :as => :search
      end

      resources :servicos, except: [:show] do
      end
    end
    resources :equipe_funcoes
    resources :servicos do
      collection do
        get :autocomplete_nome
      #   post 'search_by_registration', as: 'search_by_registration'
      end
    end
  end

  # You can have the root of your site routed with "root"
  devise_for :users
  devise_scope :user do
    root "devise/sessions#new"
  end
end
