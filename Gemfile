source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

#ruby '2.6.3'
gem 'rails', '>= 6.0'
gem 'puma', '~> 4.3'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'

gem 'rest-client', '~> 2.1'
gem 'figaro'
gem 'pg', '~> 1.1'
gem 'tinymce-rails'
gem 'tinymce-rails-langs'
gem 'bcrypt_pbkdf', '< 2.0', :require => false
gem 'ed25519', '~> 1.2', '>= 1.2.4'
gem 'roo', '2.4'
gem 'roo-xls'
gem 'whenever', require: false
gem 'nokogiri'
gem 'spree', '~> 4.2.0'
gem 'spree_auth_devise', '~> 4.3'
gem 'spree_gateway', '~> 3.9'
gem 'spree_social', github: 'spree-contrib/spree_social'
gem 'spree_i18n', '~> 5.0'
gem 'deface'
gem 'spree_static_content', github: 'spree-contrib/spree_static_content'
gem 'spree_volume_pricing', github: 'spree-contrib/spree_volume_pricing'
gem 'spree_related_products', github: 'spree-contrib/spree_related_products'
gem 'spree_analytics_trackers', '~> 2.0'
gem 'spree_sitemap', github: 'spree-contrib/spree_sitemap'
gem 'spree_product_feed', github: 'matthewkennedy/spree_product_feed'
gem 'spree_mail_settings', github: 'spree-contrib/spree_mail_settings'

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  gem 'capistrano'#, '~> 3.0.1'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'#, '~> 1.1.0'
  gem 'capistrano-rails-console'
  gem 'capistrano-rvm'#, '~> 0.1.1'
  gem 'capistrano3-unicorn'
  gem 'capistrano-spree'
  gem 'hub', :require => nil
  gem 'rails_layout'
end

group :development, :test do
  gem 'byebug', platform: :mri
end

group :production do
  gem 'unicorn'
end
