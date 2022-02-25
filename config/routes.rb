Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'pages#index'
  resources :articles

  # routes to authenticate user - signup
  get 'signup', to: 'users#new'
  #post 'users', to: 'users#create' # post request to send completed form to the user create action
  resources :users, except: [:new] # we replace the line 10 with this. we have already define new action in line 9, dont need new route again
end
