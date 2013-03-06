listen '/tmp/.hotshottt.sock'
preload_app true
worker_processes 2
app_dir = "#{ENV['HOME']}/projects/hotshottt"

before_fork do |server, worker|
  old_pid = "#{app_dir}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill 'QUIT', File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

pid "#{app_dir}/tmp/pids/unicorn.pid"
stdout_path "#{app_dir}/log/unicorn.log"
stderr_path "#{app_dir}/log/error.log"
