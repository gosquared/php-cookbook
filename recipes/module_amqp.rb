package "libtool"

remote_file "/usr/local/src/rabbitmq-c.tar.bz2" do
  source "http://hg.rabbitmq.com/rabbitmq-c/archive/ef4df46cc0db.tar.bz2"
  checksum "a7d73a464572c5612c85b6032eb685f6449a89eed5f2a264342c4498b743694b"
  not_if "[ -e /usr/local/src/rabbitmq-c.tar.bz2 ]"
end

bash "inflate rabbitmq-c" do
  cwd "/usr/local/src"
  code %{
    mkdir rabbitmq-c
    tar --strip-components=1 -C rabbitmq-c -jxvf rabbitmq-c.tar.bz2
  }
  not_if "[ -d /usr/local/src/rabbitmq-c ]"
end

remote_file "/usr/local/src/rabbitmq-c/codegen.tar.bz2" do
  source "http://hg.rabbitmq.com/rabbitmq-codegen/archive/dfff9832e2d7.tar.bz2"
  checksum "d0d734bae557ee1a8a22c7ff030c9e6c2cb35af7f6582af25f7124d7f9fdffbf"
  not_if "[ -e /usr/local/src/rabbitmq-c/codegen.tar.bz2 ]"
end

bash "build rabbitmq" do
  cwd "/usr/local/src/rabbitmq-c"
  code %{
  mkdir codegen
  tar --strip-components=1 -C codegen -jxvf codegen.tar.bz2
  autoreconf -i && ./configure && make && make install
  }
  not_if "[ -f /usr/local/lib/librabbitmq.so ]"
end

unless `pecl list | grep -c amqp`.chomp == "1"
  php_pear "amqp" do
    action :install
    preferred_state :beta
  end

  template "#{node['php']['ext_conf_dir']}/amqp.ini" do
    source "extension.ini.erb"
    cookbook "php"
    owner "root"
    group "root"
    mode "0644"
    variables(:name => "amqp", :directives => [])
  end

  create_extension "amqp"
end
