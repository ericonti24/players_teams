Rails.application.routes.draw do
  get '/' => 'teams#index'


  resources :players, only: [:new, :create, :index]

  resources :teams do 
    resources :players, shallow: true #index, create, new
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
