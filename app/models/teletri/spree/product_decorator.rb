module Teletri
  module Spree
      module ProductDecorator

        def self.prepended(base)
          #::Spree::Product.whitelisted_ransackable_scopes = %w[not_discontinued search_by_name search_by_property_value]
          base.whitelisted_ransackable_scopes = %w[not_discontinued search_by_name search_by_property_value]
        end

        def self.search_by_property_value(query)
          puts "query - "+query
        end

      end
  end
end


if ::Spree::Product.included_modules.exclude?(Teletri::Spree::ProductDecorator)
  ::Spree::Product.prepend Teletri::Spree::ProductDecorator
end
