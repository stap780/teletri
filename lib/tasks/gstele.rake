#  encoding : utf-8
namespace :gstele do
  desc "gstele"

  task spree_update_gstele: :environment do
    puts 'Обновляем gstele' +" Время -"+"#{Time.zone.now}"

    pr_jabra = Spree::Product.where('name LIKE ?', '%Jabra%' )
  	pr_jabra.each do |pr|
      pr.stock_items.first.adjust_count_on_hand(0)
    end
    pr_snom = Spree::Product.where('name LIKE ?', '%Snom%' )
    pr_snom.each do |pr|
      pr.stock_items.first.adjust_count_on_hand(0)
    end
  	# Gstele.update_all price: 0
  	# Gstele.update_all cost_price: 0
      uri = ["http://www.gstele.com/stock/jabra/csv.php", "http://www.gstele.com/stock/snom/csv.php"]
      uri.each do |uri|
  		if uri == "http://www.gstele.com/stock/jabra/csv.php"
  			download_path = "#{Rails.public_path}"+"/jabra.csv"
  			download_response = open(uri, http_basic_authentication: ["jabra", Rails.application.secrets.gstele_jabra])
  			IO.copy_stream(download_response, download_path)
  		else
  			download_path = "#{Rails.public_path}"+"/snom.csv"
  			download_response = open(uri, http_basic_authentication: ["snom", Rails.application.secrets.gstele_snom])
  			IO.copy_stream(download_response, download_path)
  		end
      end
      files = ["#{Rails.public_path}"+"/jabra.csv", "#{Rails.public_path}"+"/snom.csv"]
      files.each do |file|
      spreadsheet = Roo::CSV.new(file, csv_options: {col_sep: ";", :encoding => 'windows-1251:utf-8'})
      (2..spreadsheet.last_row).each do |i|
  			sku = spreadsheet.cell(i,'A').to_s.gsub('.0','').squish
  			title_file = spreadsheet.cell(i,'B')
  			price_file = spreadsheet.cell(i,'D')
  			valute = spreadsheet.cell(i,'E')
  			quantity = spreadsheet.cell(i,'C').present? ? spreadsheet.cell(i,'C') : 0

  			if file == "#{Rails.public_path}"+"/jabra.csv"
  				cost_price = (price_file.to_f - (price_file.to_f*0.43).to_f).round(2)
  				sale_price = (cost_price.to_f + cost_price.to_f*0.45).round(2)

  				add_price = Spree::Price.new( currency: "EUR", amount: sale_price.to_f)
  				vendor = 'Jabra'
  				title = title_file
  				description = title_file
  			else
  				# cost_price = (price_file.to_f * 0.85).to_f.round(2)
  				sale_price = (price_file.to_f - (price_file.to_f*0.10).to_f).round(2) #это для файла snom так как там доллары
  				add_price = Spree::Price.new( currency: "USD", amount: sale_price.to_f)
  				vendor = 'Snom'
  				title = title_file.present? ? title_file.gsub('Телефон','').gsub('snom','Snom') : nil
  				description = "телефон"
  			end

  			puts "sku - "+sku.to_s+" title - "+title.to_s

  			variant = Spree::Variant.find_by_sku(sku)
			if variant
				product = variant.product
# 				puts product.slug.to_s
		    	product.master.prices << add_price
# 		    	puts quantity.to_s
# 		    	puts product.stock_items.first.count_on_hand.to_s
				product.stock_items.first.adjust_count_on_hand(quantity.to_i)
			else
				if title.present?
				new_product = Spree::Product.create!(sku: sku, name: title, shipping_category_id: 1, description: description, price: 0)
				new_product.stock_items.first.adjust_count_on_hand(quantity.to_i)
				new_product.master.prices << add_price
				product_proper = Spree::ProductProperty.create!( property_name: 'Производитель', value: vendor )
				new_product.product_properties << product_proper
				end
  			end
  		end
  	end

  	check_jabra = File.file?("#{Rails.public_path}"+"/jabra.csv")
  	if 	check_jabra
  	   File.delete("#{Rails.public_path}"+"/jabra.csv")
  	end
  	check_snom = File.file?("#{Rails.public_path}"+"/snom.csv")
  	if 	check_snom
  	   File.delete("#{Rails.public_path}"+"/snom.csv")
  	end

  	puts 'Закончили Обновляем gstele' +" Время -"+"#{Time.zone.now}"
	end


end
