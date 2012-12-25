GoogleCloudPrintExample::Application.routes.draw do
  resources :users

  resources :printers do
    collection do
      get 'refresh'
    end
  end

  match 'test-print/:id' => 'printers#queue_test', :as => :test_print

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

  root :to => 'printers#index'
end
