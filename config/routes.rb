Rides::Application.routes.draw do
  root :to => 'people#index'

  resources :people do
    resources :vehicles
  end

  resources :trips do
    resources :arrangements
  end
end
