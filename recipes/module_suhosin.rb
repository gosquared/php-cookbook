package "php5-suhosin" do
  action :install
end

create_extension "suhosin" do
  provider "apt"
end

bash "Allow cross protocol sessions" do
  code "echo 'suhosin.session.cryptdocroot=Off' >> #{node[:php][:ext_conf_dir]}/suhosin.ini"
  only_if "[ $(grep -c cryptdocroot #{node[:php][:ext_conf_dir]}/suhosin.ini) -eq 0 ]"
end
