task default: %w[gcc]

task :musl do
  sh 'cd musl; ./configure && make && sudo make install'
  sh 'tar -zcvf musl.tar.gz /usr/local/musl'
end

task :gcc do
  prefix = '/Users/nguyen-v/Workspace/personal/binary_builder/gcc'
  #Rake::Task[:compile].invoke('https://gcc.gnu.org/pub/gcc/infrastructure/gmp-6.1.0.tar.bz2', 'gmp-6.1.0', prefix)
  #Rake::Task[:compile].reenable
  Rake::Task[:compile].invoke('https://gcc.gnu.org/pub/gcc/infrastructure/mpfr-3.1.4.tar.bz2', 'mpfr-3.1.4', prefix, "--with-gmp=#{prefix}")
  Rake::Task[:compile].reenable
  Rake::Task[:compile].invoke('https://gcc.gnu.org/pub/gcc/infrastructure/mpc-1.0.3.tar.gz', 'mpc-1.0.3', prefix, "--with-mpfr=#{args.prefix}")
  Rake::Task[:compile].reenable
  Rake::Task[:compile].invoke('https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.18.tar.bz2', 'isl-0.18', prefix, "--with-gmp-prefix=#{prefix}")

  sh 'curl -OJL https://ftpmirror.gnu.org/gcc/gcc-9.2.0/gcc-9.2.0.tar.xz && tar -xf gcc-9.2.0.tar.xz'
  sh "cd gcc-9.2.0 && ./configure --with-gmp=#{prefix} --with-mpfr==#{prefix} --with-mpc=#{prefix} && make && sudo make install"
end

task :compile, [:url, :package_name, :prefix, :config_flag] do |t, args|
  args.with_defaults(config_flag: "")
  file_name = File.basename(args.url)
  #puts "Invoked with: ", file_name
  sh "curl -OJL #{args.url} && tar -xf #{file_name}"
  sh "cd #{args.package_name} && ./configure --prefix=#{args.prefix} #{args.config_flag} && make && make install"
end
