source 'https://rubygems.org'

ruby '3.3.0'

gem 'rails', '~> 7.2.2.1'

gem 'pg', "~> 1.1"

gem 'puma', '>= 6.0'

gem 'importmap-rails'

gem 'turbo-rails'

gem 'stimulus-rails'

gem 'jbuilder'

gem 'mini_racer', platforms: :ruby

gem 'aws-sdk-s3'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.13'

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem 'kamal', require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[ mri windows ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Preview emails in the browser [https://github.com/plataformatec/letter_opener]
  gem 'letter_opener'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end

# Use Solid Queue for background jobs
gem 'mission_control-jobs'
gem 'solid_queue', '>= 0.3.2'

# Use Solid Cache for caching
gem 'solid_cache'

# Use Devise for authentication
gem 'devise'

# Spree gems
spree_opts = if ENV['SPREE_PATH']
              { 'path': ENV['SPREE_PATH'] }
             else
              { 'github': 'spree/spree', 'branch': 'main' }
             end
gem 'spree', spree_opts
gem 'spree_emails', spree_opts
gem 'spree_sample', spree_opts

gem 'spree_admin', spree_opts

gem 'spree_storefront', spree_opts
gem 'spree_stripe', { 'github': 'spree/spree_stripe', 'branch': 'main' }

gem 'spree_i18n'

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem 'thruster', require: false