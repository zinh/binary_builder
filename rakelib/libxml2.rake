task :libxml2, [:prefix] do |t, args|
  args.with_default(prefix: '/usr/local/libxml2')
  Rake::Task[:compile].invoke('http://xmlsoft.org/sources/libxml2-2.9.10.tar.gz', 'libxml2-2.9.10', args.prefix)
  Rake::Task[:compile].reenable
  #sh 'tar -zcf libxml2.tar.gz /usr/local/libxml2'
end
