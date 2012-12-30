GoogleCloudPrintExample::Application.routes.draw do
  devise_for :users

  resources :printers do
    collection do
      get 'refresh'
    end
  end

  match '/auth/google_oauth2/callback' => 'sessions#create'
  match '/logout' => 'sessions#destroy'
  
  root :to => 'sessions#new'
end
