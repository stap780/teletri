#  encoding : utf-8
namespace :ins3 do
  desc "insales"
  task get_root: :environment do
  	puts Rails.public_path.to_s
  end
  task spree_create_pr: :environment do
		puts 'start '+Time.now.to_s
		api_key = Rails.application.secrets.insales_login
		domain = Rails.application.secrets.insales_domain
		password = Rails.application.secrets.insales_pass

	    count = 654
		page_size = 1
		while count > 0
			pr_uri = "http://"+api_key+":"+password+"@"+domain+"/admin/products.json?per_page=100&page="+page_size.to_s
			resp = RestClient.get(pr_uri)
			products = JSON.parse(resp)
			products.each do |p|
				puts p['id']
				data = {
					name: p['title'],
					price: p['variants'].first['price'].to_s,
					shipping_category_id: "1",
					description: p["product_field_values"][0] != nil && p["product_field_values"][0]["value"] != nil ? p['description']+" "+p["product_field_values"][0]["value"] : p['description'],
					meta_title: p['html_title'],
					meta_description: p['meta_description'],
					sku: p['variants'].first['sku'],
					compare_at_price: p['variants'].first['old_price'].to_s,
					cost_price: p["variants"].first["cost_price"].to_s,
					available_on: p["created_at"]
					}

					product = Spree::Product.create!(data)
					product.stock_items.first.adjust_count_on_hand(p["variants"].first["quantity"])

					pr_id = product.id
					prs = p['properties']
					#property = p['properties'].first
					prs.each do |property|
						property_title = property["title"]
						charact = p["characteristics"].select {|chara| chara["property_id"] == property["id"]}.first
						charact_title = charact["title"]
						Rake::Task["ins3:spree_create_pr_proper"].invoke(pr_id, property_title, charact_title)
						Rake::Task["ins3:spree_create_pr_proper"].reenable
					end
					p["images"].each do |image|
						image_url = image["original_url"]
						Rake::Task["ins3:spree_create_pr_image"].invoke(pr_id, image_url)
						Rake::Task["ins3:spree_create_pr_image"].reenable
					end
			end
		count = count - 100
		page_size = page_size + 1
		sleep 1
	  	end
		puts 'finish '+Time.now.to_s
	end

	task :spree_create_pr_proper, [:product_id, :property_title, :charact_title] => :environment do |t, args|
		puts 'start '+Time.now.to_s

			product_proper = Spree::ProductProperty.create!(property_name: args[:property_title], value: args[:charact_title])
			product = Spree::Product.find(args[:product_id])
			product.product_properties << product_proper

		puts 'finish '+Time.now.to_s
	end

	task :spree_create_pr_image, [:product_id, :image_url] => :environment do |t, args|
		require 'open-uri'
		puts 'start '+Time.now.to_s
			url = URI.encode(args[:image_url])
			file = URI.parse(url).open
			filename = args[:image_url].split('/').last
			image = Spree::Image.create!(attachment: { io: file, filename: filename })
			product = Spree::Product.find(args[:product_id])
			product.images << image
		puts 'finish '+Time.now.to_s
	end

  # property = Spree::Property.first
  # products = Spree::Product.all.select{|pr| pr.property(proper1.name)}
  # products = Spree::Product.all.map{|pr| pr.property(proper1.name)}.uniq

end
