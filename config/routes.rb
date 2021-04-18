Rails.application.routes.draw do
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to
  # Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the
  # :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being
  # the default of "spree".
  mount Spree::Core::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # post "/admin/products/delete_selected", to: "spree/admin/products#delete_selected", as: "delete_selected_admin_product"
  Spree::Core::Engine.add_routes do

    get '/delivery', to: 'static_content#show', as: 'delivery'
    get '/payment', to: 'static_content#show', as: 'payment'

    namespace :admin, path: Spree.admin_path do

      resources :products do
        collection do
          post :delete_selected
          get :edit_multiple_product_taxon
          put :update_multiple_products_taxon
        end
      end

    end

  end

end
