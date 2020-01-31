task default: %w[gcc]

task :musl do
  sh 'cd musl; ./configure && make && sudo make install'
  sh 'tar -zcvf musl.tar.gz /usr/local/musl'
end

task :gcc => [:gmp, :mpfr, :mpc]do
  sh 'curl -OJL https://ftpmirror.gnu.org/gcc/gcc-9.2.0/gcc-9.2.0.tar.xz && tar -xf gcc-9.2.0.tar.xz'
  sh "cd gcc-9.2.0 && ./configure --with-gmp=#{prefix} --with-mpfr==#{prefix} --with-mpc=#{prefix} && make && sudo make install"
end

task :gmp do
  package_name = "gmp-6.1.0"
  prefix = "/usr/local/gcc"
  sh "curl -OJL http://gcc.gnu.org/pub/gcc/infrastructure/#{package_name}.tar.bz2 && tar -xf #{package_name}.tar.bz2"
  sh "cd #{package_name} && ./configure --prefix=#{prefix} && make && sudo make install"
end

task :mpfr do
  package_name = "pfr-3.1.4"
  prefix = "/usr/local/gcc"
  sh "curl -OJL http://gcc.gnu.org/pub/gcc/infrastructure/#{package_name}.tar.bz2 && tar -xf #{package_name}.tar.bz2"
  sh "cd #{package_name} && ./configure --prefix=#{prefix} && make && sudo make install"
end

task :mpc do
  package_name = "mpc-1.0.3"
  prefix = "/usr/local/gcc"
  sh "curl -OJL http://gcc.gnu.org/pub/gcc/infrastructure/#{package_name}.tar.gz && tar -xf #{package_name}.tar.gz"
  sh "cd #{package_name} && ./configure --prefix=#{prefix} && make && sudo make install"
end
