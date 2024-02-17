Rails.application.routes.draw do
  get 'expenses/index'
  get 'expenses/new'
  # get "/home/index"
  resources :groups do
    resources :expenses, only: [:index, :new, :create]
  end
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'groups#index', as: :authenticated_root_path
    end
    unauthenticated do
      root "home#index", as: :unauthenticated_root_path
    end
  end
end