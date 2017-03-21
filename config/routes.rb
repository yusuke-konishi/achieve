Rails.application.routes.draw do
  get 'notifications/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #devise_for :users
  resources :blogs do
    resources :comments

    collection do
      post :confirm
    end
  end

  # "もどる" 実行時の new アクションに POST を追加
  match "blogs/new", :via => :post, :as => 'new_blog_post'

  resources :contacts, only: [:new, :create] do
    collection do
      post :confirm
    end
  end

  # "もどる" 実行時の new アクションに POST を追加
  match "contacts/new", :via => :post, :as => 'new_contact_post'
  # 単純に post で new アクションに飛ばすなら… (@ 2016/07/24 宮下さんのテーマ授業)
  # post 'contacts/new' => 'contacts#new'

  root 'top#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users, only: [:index, :show]

  resources :relationships, only: [:create, :destroy]

  resources :conversations do
    resources :messages
  end

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
