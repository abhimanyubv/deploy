env = ENV["RAILS_ENV"] || "production"

working_directory "/home/vagrant/apps/deploy"
pid "/home/vagrant/apps/deploy/tmp/pids/unicorn.pid"
stderr_path "/home/vagrant/apps/deploy/log/unicorn_error.log"
stdout_path "/home/vagrant/apps/deploy/log/unicorn.log"

listen "/tmp/unicorn_puma.sock"
worker_processes 4
timeout 30
preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end