task :compile, [:url, :package_name, :prefix, :config_flag, :env] do |t, args|
  args.with_defaults(config_flag: "", env: {})
  file_name = File.basename(args.url)
  #puts "Invoked with: ", file_name
  sh "curl -OJL #{args.url} && mkdir -p #{args.package_name} && tar -xf #{file_name} -C #{args.package_name} --strip-component=1"
  if args.env.empty?
    sh "cd #{args.package_name} && ./configure --prefix=#{args.prefix} #{args.config_flag} && make && make install"
  else
    sh args.env, "cd #{args.package_name} && ./configure --prefix=#{args.prefix} #{args.config_flag} && make && sudo make install"
  end
end
