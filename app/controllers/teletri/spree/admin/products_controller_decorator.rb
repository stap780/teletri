module Teletri
  module Spree
    module Admin
      module ProductsControllerDecorator

        def self.prepended(base)
            base.before_action :load_data#, only: :delete_selected
        end
        def delete_selected1
          puts params
          puts "delete_selected"
        end

        def delete_selected
          puts "here"
          puts params
          puts "params[:delete_product_ids] - "+params[:delete_product_ids].to_s
          puts @object
          products = ::Spree::Product.where(id: params[:delete_product_ids]) # friendly - только в товарах и наверно в taxon
      		products.each do |product|
      		    product.destroy
      		end
      		respond_to do |format|
      		  format.html { redirect_to collection_url }
      		  format.json { render json: {:status => "ok", :message => "Товары удалёны"} }
            format.js { render :nothing => true }
      		end
        end

        def edit_multiple_product_taxon
          # puts params[:product_ids].present?
          if params[:product_ids].present?
      			@products = ::Spree::Product.find(params[:product_ids])
      			respond_to do |format|
      			  format.js
      			end
      		else
      			redirect_to products_url
      		end
        end

        def update_multiple_products_taxon
          @products = ::Spree::Product.find(params[:product_ids]) #.reject!(&:blank?)
          taxon_ids = params[:taxon_ids].reject!(&:blank?)
          puts "taxon_ids - "+taxon_ids.to_s
      		@products.each do |pr|
            new_taxons = []
            taxon_ids.each do |tx|
              puts tx.to_i
              if !pr.taxon_ids.include?(tx.to_i)
                new_taxons = pr.taxon_ids.push(tx.to_i)
              else
                new_taxons = pr.taxon_ids
              end
            end
            puts "new_taxons - "+new_taxons.uniq.to_s
            pr.update!(taxon_ids: new_taxons.uniq)
      		end
      		flash[:notice] = 'products taxon обновлены'
      		redirect_to collection_url
        end

      end
    end
  end
end

::Spree::Admin::ProductsController.prepend Teletri::Spree::Admin::ProductsControllerDecorator if ::Spree::Admin::ProductsController.included_modules.exclude?(Teletri::Spree::Admin::ProductsControllerDecorator)
