package "php5-suhosin" do
  action :install
end

create_extension "suhosin" do
  provider "apt"
end

template "#{node[:php][:ext_conf_dir]}/suhosin.ini" do
  owner "root"
  group "root"
  mode 0644
  backup false
end
