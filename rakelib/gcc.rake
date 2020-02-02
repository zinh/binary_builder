namespace :gcc do
  task :gcc, [:version, :prefix] do |t, args|
    args.with_defaults(version: '9.2.0', prefix: '/usr/local/gcc')
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

    env = {
      'CPPFLAGS' => "-I#{prefix}/include",
      'PKG_CONFIG_PATH' => "#{prefix}/lib/pkgconfig",
      'LDFLAGS' => "-L#{prefix}/lib"
    }

    Rake::Task[:compile].invoke('https://ftpmirror.gnu.org/gcc/gcc-9.2.0/gcc-9.2.0.tar.xz', 'gcc-9.2.0', prefix, gcc_config_flags, env)

    sh "tar -zcvfC gcc-#{args.version}.tar.gz /usr/local gcc"
  end
end
