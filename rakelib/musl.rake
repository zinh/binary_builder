task :musl do
  sh 'cd musl; ./configure && make && sudo make install'
  sh 'tar -zcvf musl.tar.gz /usr/local/musl'
end

