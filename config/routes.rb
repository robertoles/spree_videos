Spree::Core::Engine.routes.append do
  resources :videos
  resources :products do
    match 'videos' => 'videos#product_index'
  end
  
  namespace :admin do
    resources :products do
      # adding in a bunch of routes elsewhere, this is the last gem thats loaded, and it overwrites other routes used, making them all fail
      get :related, :on => :member
      resources :relations
        
      collection do
        get :search
      end

      resources :product_properties do
        collection do
          post :update_positions
        end
      end
      resources :images do
        collection do
          post :update_positions
        end
      end
      member do
        get :clone
      end
      resources :variants do
        collection do
          post :update_positions
        end
      end
      
      resources :videos do
        collection do
          post :update_positions
        end
      end
    end
  end
end
