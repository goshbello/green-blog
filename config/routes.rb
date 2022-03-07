Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'pages#index'
  resources :articles

  # routes to authenticate user - signup
  get 'signup', to: 'users#new'
  #post 'users', to: 'users#create' # post request to send completed form to the user create action
  resources :users, except: [:new] # Replaced line 10 with this. As new action already defined in line 9, dont need new route again

  get 'login', to: 'sessions#new'
	post 'login', to: 'sessions#create'
	delete 'logout', to: 'sessions#destroy'

  resources :categories, except: [:destroy]
end
