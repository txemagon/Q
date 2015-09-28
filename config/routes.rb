Rails.application.routes.draw do

  resources :acronyms
  resources :areas do
    collection do
      get :manage
      post :rebuild
    end
  end

  resources :levels do
    collection do
      get :manage

      # required for Sortable GUI server side actions
      post :rebuild
    end
  end

  resources :board, only: [:index, :destroy] do
    member do
      put 'confirm'
      put 'banish'
      put 'welcome'
    end
  end
  #get 'board/index'
  #match "board/:action/:id(.:format)", :to => "board/welcome", :via => [:put]
  ##put "board/confirm/:id(.:format)", :to => "board/confirm"
  #put "board/banish/:id(.:format)",  :to => "board/banish"
  #delete 'board/:id(.:format)', :to => 'board#destroy'

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => "registrations"
  }
  resources :register_models

  root 'register_models#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
