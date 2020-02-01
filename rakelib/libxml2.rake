task :libxml2 do |t, args|
  prefix = "/usr/local/libxml2"
  Rake::Task[:compile].invoke('http://xmlsoft.org/sources/libxml2-2.9.10.tar.gz', 'libxml2-2.9.10', prefix)
  sh 'tar -zcf libxml2.tar.gz /usr/local/libxml2'
end

