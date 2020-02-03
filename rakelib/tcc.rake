namespace :tcc do
  task :install, [:version, :prefix] do |t, args|
    args.with_defaults(version: '0.9.27', prefix: '/usr/local/tcc')
    Rake::Task[:compile].invoke('http://download.savannah.gnu.org/releases/tinycc/tcc-0.9.27.tar.bz2', "tcc-#{args.version}", args.prefix)
    sh 'tar -zcf tcc.tar.gz /usr/local/tcc'
  end
end
