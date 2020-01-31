task default: %w[gcc]

task :musl do
  sh 'cd musl; ./configure && make && sudo make install'
  sh 'tar -zcvf musl.tar.gz /usr/local/musl'
end

task :gcc do
  sh 'curl -OJL https://ftpmirror.gnu.org/gcc/gcc-9.2.0/gcc-9.2.0.tar.xz && tar -xf gcc-9.2.0.tar.xz'
  sh 'cd gcc-9.2.0 && ./configure && make && sudo make install'
end
