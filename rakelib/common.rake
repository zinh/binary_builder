task :compile, [:url, :package_name, :prefix, :config_flag] do |t, args|
  args.with_defaults(config_flag: "")
  file_name = File.basename(args.url)
  #puts "Invoked with: ", file_name
  sh "curl -OJL #{args.url} && mkdir -p #{args.package_name} && tar -xf #{file_name} -C #{args.package_name} --strip-component=1"
  sh "cd #{args.package_name} && ./configure --prefix=#{args.prefix} #{args.config_flag} && make && sudo make install"
end

