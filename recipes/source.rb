configure_options = node['php']['configure_options'].join(" ")

include_recipe "build-essential"
include_recipe "xml"
include_recipe "mysql::client" if configure_options =~ /mysql/

dependencies = value_for_platform(
    ["centos","redhat","fedora"] =>
        {"default" => %w{ bzip2-devel libc-client-devel curl-devel freetype-devel gmp-devel libjpeg-devel krb5-devel libmcrypt-devel libpng-devel openssl-devel t1lib-devel }},
    [ "debian", "ubuntu" ] =>
        {"default" => %w{ libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-dev libkrb5-dev libmcrypt-dev libpng12-dev libssl-dev libt1-dev }},
    "default" => %w{ libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-dev libkrb5-dev libmcrypt-dev libpng12-dev libssl-dev libt1-dev }
  )

dependencies.each do |name|
  package name
end

version = node['php']['version']

remote_file "/usr/local/src/php-#{version}.tar.bz2" do
  source "#{node['php']['url']}/php-#{version}.tar.bz2"
  checksum node['php']['checksum']
  mode "0644"
  not_if "which php"
end

bash "build php" do
  cwd "/usr/local/src"
  code %{
    [ ! -d php-#{version} ] && tar -jxvf php-#{version}.tar.bz2
    cd php-#{version} && ./configure #{configure_options}
    make && make install
    EOF
  }
  not_if "which php"
end

directory node['php']['conf_dir'] do
  owner "root"
  group "root"
  mode "0755"
  recursive true
end

directory node['php']['ext_conf_dir'] do
  owner "root"
  group "root"
  mode "0755"
  recursive true
end

template "#{node['php']['conf_dir']}/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end
