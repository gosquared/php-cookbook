package "php5-xmlrpc" do
  action :install
end

create_extension "xmlrpc" do
  provider "apt"
end
