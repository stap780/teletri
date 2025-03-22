source 'https://rubygems.org'

ruby '3.3.0'

gem 'rails', '~> 7.2.2.1'

gem 'pg', '~> 1.1'

gem 'puma', '>= 6.0'

gem 'importmap-rails'

gem 'turbo-rails'

gem 'stimulus-rails'

gem 'jbuilder'

gem 'mini_racer', platforms: :ruby

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1", group: :production

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.13'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[ mri windows ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Preview emails in the browser [https://github.com/plataformatec/letter_opener]
  gem 'letter_opener'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # gem 'capistrano', require: false
  # gem 'capistrano-bundler', require: false
  # gem 'capistrano-rails', require: false
  # gem 'capistrano-rails-console', require: false
  # gem 'capistrano-rvm', require: false
  # gem 'capistrano3-puma', require: false
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

gem 'kamal'