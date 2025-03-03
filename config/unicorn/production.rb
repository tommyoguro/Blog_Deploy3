 worker_processes  2   # 1
 working_directory "/var/www/cdp_web_web_aws_deploy_task/current"    # 2
 stderr_path "log/unicorn.stderr.log"    # 3変更
 stdout_path "log/unicorn.stdout.log"    # 4変更
 timeout 30    # 5
 listen "/var/www/cdp_web_web_aws_deploy_task/current/tmp/sockets/unicorn.sock"    # 6
 pid '/var/www/cdp_web_web_aws_deploy_task/current/tmp/pids/unicorn.pid'   # 7
 preload_app true    # 8

 before_fork do |server, worker|   # 9
   defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
   old_pid = "#{server.config[:pid]}.oldbin"
   if old_pid != server.pid
     begin
       sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
       Process.kill(sig, File.read(old_pid).to_i)
     rescue Errno::ENOENT, Errno::ESRCH
     end
   end
 end

 after_fork do |server, worker|    # 9
   defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
 end