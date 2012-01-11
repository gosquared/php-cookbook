define :create_extension, :provider => "pecl" do
  ext_dir = case params[:provider]
    when "apt"
      "#{node['php']['extensions_dir']}/../20090626*"
    else
      "$(#{params[:provider]} config-get ext_dir)"
    end
  execute "ln -nfs #{ext_dir}/#{params[:name]}.so #{node['php']['extensions_dir']}/#{params[:name]}.so"
end

define :remove_extension do
  execute "rm #{node['php']['extensions_dir']}/#{params[:name]}.so"
end
