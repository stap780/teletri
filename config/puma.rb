#!/usr/bin/env puma

directory '/var/www/teletri/current'
rackup '/var/www/teletri/current/config.ru'
environment 'production'

tag ''

pidfile '/var/www/teletri/shared/tmp/pids/puma.pid'
state_path '/var/www/teletri/shared/tmp/pids/puma.state'
stdout_redirect '/var/www/teletri/current/log/puma.access.log', '/var/www/teletri/current/log/puma.error.log', true

threads 4,50

bind 'unix:///var/www/teletri/shared/tmp/sockets/teletri-puma.sock'

workers 0

restart_command 'bundle exec puma'


preload_app!


on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = ''
end


before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart

# Run Solid Queue with rails server
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"] || Rails.env.development?