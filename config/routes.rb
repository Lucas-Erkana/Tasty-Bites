Rails.application.routes.draw do
  root "home#index"
  devise_for :users
  resources :recipes do
    resources :recipe_foods, only: [:new, :create, :destroy, :show, :edit, :update]
  end
  resources :foods, only: [:index, :show, :new, :create, :destroy]
  get "public_recipes", to: "public_recipes#index"
  get 'not_accessible', to: 'errors#not_accessible'
  get "general_shopping_list", to: "general_shopping_list#index"
  get '*path', to: 'errors#not_found'
end
