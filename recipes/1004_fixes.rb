arch = (node['kernel']['machine'] =~ /x86_64/ ? 'amd64' : 'i386')

libicu_file = "libicu38_3.8-6ubuntu0.2_#{arch}.deb"
remote_file "/usr/local/src/#{libicu_file}" do
  checksum (arch == 'amd64' ? 'f5f18a22e10b55f60ddab123d22d1ad68a6b37814bb5245e685b9d193b56d19a' : '42d091d91cc1212b44622d4939f0e8d57c21d258bea80e8eece70465f3d5e0c2')
  source "http://security.ubuntu.com/ubuntu/pool/main/i/icu/#{libicu_file}"
  action :create_if_missing
end

package "libicu" do
  action :install
  source "/usr/local/src/#{libicu_file}"
  provider Chef::Provider::Package::Dpkg
end

libkrb_file = "libkrb53_1.6.dfsg.3~beta1-2ubuntu1.8_#{arch}.deb"
remote_file "/usr/local/src/#{libkrb_file}" do
  checksum (arch == 'amd64' ? '0dc23917cef611dc4e3d65b7614b5243fdd14c92d5c28285e2d930b02bcb36f7' : '9f62f90d9b40d1f44bef00bf0f8ed37473b1cdd9cc6cf4e080c35d1b7b5cce37')
  source "http://security.ubuntu.com/ubuntu/pool/main/k/krb5/#{libkrb_file}"
  action :create_if_missing
end

package "libkrb" do
  action :install
  source "/usr/local/src/#{libkrb_file}"
  provider Chef::Provider::Package::Dpkg
end

libtool_file = "libtool_1.5.26-1ubuntu1_#{arch}.deb"
remote_file "/usr/local/src/#{libtool_file}" do
  checksum (arch == 'amd64' ? '3d591edbfc8253956de332ddc65b5aaf24949853f670251ec833007b84646de6' : 'bdb349abc19345f9abb012de0383f69776368ab7c1271fe6e358c60eee970f09')
#  source "http://mirrors.us.kernel.org/ubuntu//pool/main/libt/libtool/#{libtool_file}"
  source "http://ubuntu.media.mit.edu/ubuntu//pool/main/libt/libtool/#{libtool_file}"
  action :create_if_missing 
end

package "libtool" do
  action :install
  source "/usr/local/src/#{libtool_file}"
  provider Chef::Provider::Package::Dpkg
end

libltdl_file = "libltdl3_1.5.26-1ubuntu1_#{arch}.deb"
remote_file "/usr/local/src/#{libltdl_file}" do
  checksum (arch == 'amd64' ? 'd0a8bfb2864b7c97b112babd73933224afbb3e78157e955199658d36467dbc92' : '91b77bff9cc45672525ee0f39761633c21648de78209002068ae78a09abd3e4f')
#  source "http://mirrors.us.kernel.org/ubuntu//pool/main/libt/libtool/#{libltdl_file}"
  source "http://ubuntu.media.mit.edu/ubuntu//pool/main/libt/libtool/#{libltdl_file}"
  action :create_if_missing
end

package "libltdl" do
  action :install
  source "/usr/local/src/#{libltdl_file}"
  provider Chef::Provider::Package::Dpkg
end

directory node['php']['extensions_dir'] do
  owner "root"
  group "root"
  mode "0755"
  recursive true
end
