Rails.application.routes.draw do

  get 'pots/filter/:tag', to: 'posts#index', as: 'tag'

  resources :approvals, only: [:index]

  # redirect
  put '/approvals/pcomment/:id', to: 'pcomments#approve'
  put '/approvals/ccomment/:id', to: 'ccomments#approve'
  delete '/approvals/pcomment/:id', to: 'pcomments#disapprove'
  delete '/approvals/ccomment/:id', to: 'ccomments#disapprove'

  put '/like/ccomment/:id', to: 'ccomments#like'
  put '/dislike/ccomment/:id', to: 'ccomments#dislike'
  put '/like/pcomment/:id', to: 'pcomments#like'
  put '/dislike/pcomment/:id', to: 'pcomments#dislike'


  resources :posts do
    resources :pcomments do
      resources :ccomments
    end
  end

  root 'posts#index'

  devise_for :users, :controllers => { registrations: 'registrations' }

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
