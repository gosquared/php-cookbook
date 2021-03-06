package "php5-fpm"

service "php5-fpm" do
  action :enable
end

link "/etc/php5/fpm/php.ini" do
  to "#{node['php']['conf_dir']}/php.ini"
end

template "/etc/php5/fpm/php-fpm.conf" do
  cookbook "php"
  source "php-fpm.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "php5-fpm"), :delayed
end

template "/etc/php5/fpm/pool.d/www.conf" do
  cookbook "php"
  source "www.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "php5-fpm"), :delayed
end

template "/etc/init.d/php5-fpm" do
  source "php5-fpm.sysv.erb"
  mode "0755"
  notifies :restart, resources(:service => "php5-fpm"), :delayed
end

service "php5-fpm" do
  action :start
end
