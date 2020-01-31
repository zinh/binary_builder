task default: %w[libxml2]

task :musl do
  sh 'cd musl; ./configure && make && sudo make install'
  sh 'tar -zcvf musl.tar.gz /usr/local/musl'
end

task :gcc, [:version, :prefix] do |t, args|
  args.with_defaults(version: '9.2.0', prefix: '/Users/nguyen-v/Workspace/personal/binary_builder/gcc')
  prefix = args.prefix

  Rake::Task[:compile].invoke('https://gcc.gnu.org/pub/gcc/infrastructure/gmp-6.1.0.tar.bz2', 'gmp-6.1.0', prefix)
  Rake::Task[:compile].reenable

  Rake::Task[:compile].invoke('https://gcc.gnu.org/pub/gcc/infrastructure/mpfr-3.1.4.tar.bz2', 'mpfr-3.1.4', prefix, "--with-gmp=#{prefix}")
  Rake::Task[:compile].reenable

  Rake::Task[:compile].invoke('https://gcc.gnu.org/pub/gcc/infrastructure/mpc-1.0.3.tar.gz', 'mpc-1.0.3', prefix, "--with-mpfr=#{prefix}")
  Rake::Task[:compile].reenable

  Rake::Task[:compile].invoke('https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.18.tar.bz2', 'isl-0.18', prefix, "--with-gmp-prefix=#{prefix}")
  Rake::Task[:compile].reenable

  gcc_config_flags =  "--with-gmp=#{prefix} --with-mpfr==#{prefix} --with-mpc=#{prefix} --disable-multilib --with-isl=#{prefix}"
  Rake::Task[:compile].invoke('https://ftpmirror.gnu.org/gcc/gcc-9.2.0/gcc-9.2.0.tar.xz', 'gcc-9.2.0', prefix, gcc_config_flags)

  sh "tar -zcvfC gcc-#{args.version}.tar.gz /usr/local gcc"
end

task :libxml2 do |t, args|
  prefix = "/usr/local/libxml2"
  Rake::Task[:compile].invoke('http://xmlsoft.org/sources/libxml2-2.9.10.tar.gz', 'libxml2-2.9.10', prefix)
  sh 'ls /usr/local'
end

task :compile, [:url, :package_name, :prefix, :config_flag] do |t, args|
  args.with_defaults(config_flag: "")
  file_name = File.basename(args.url)
  #puts "Invoked with: ", file_name
  sh "curl -OJL #{args.url} && mkdir #{args.package_name} && tar -xf #{file_name} -C #{args.package_name} --strip-component=1"
  sh "cd #{args.package_name} && ./configure --prefix=#{args.prefix} #{args.config_flag} && make && sudo make install"
end

