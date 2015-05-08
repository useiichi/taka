God.watch do |w|
  w.name = "unicorn"
  w.dir = "/var/www/taka"
  w.start = "bundle exec unicorn_rails -c /var/www/taka/config/unicorn.rb -E production -D -p 13005 --path /taka"
  w.stop = "/usr/bin/env kill -s QUIT $(< /var/run/unicorn/unicorn_taka.pid)"
  w.pid_file = "/var/run/unicorn/unicorn_taka.pid"
  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.running = false
      c.interval = 5.seconds
    end
  end
end
