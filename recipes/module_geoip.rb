package "php5-geoip" do
  action :install
end

create_extension "geoip" do
  provider "apt"
end
