# This gets installed by default, I think the PHP package provides it
# Ensure the .so symlink is in the correct PHP extensions directory
create_extension "pdo" do
  provider "apt"
end
