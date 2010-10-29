Rides::Application.routes.draw do
  root :to => 'people#index'
  devise_for :people

  resources :people do
    resources :vehicles
  end

  resources :trips do
    resources :arrangements
  end
end
