namespace :httpd do
  task :httpd, [:version, :prefix] do |t, args|
    default_version =  '2.4.41'
    default_prefix =  "/usr/local/httpd-#{default_version}"

    args.with_defaults(version: '2.4.41', prefix: default_prefix)
    Rake::Task[:httpd::apr].invoke("1.7.0", default_prefix)
    url = "https://archive.apache.org/dist/httpd/httpd-#{args.version}.tar.gz"
    config_flags = "--enable-layout=Slackware-FHS --enable-mpms-shared=all --enable-mods-shared=all --enable-authnz-fcgi --enable-cgi --enable-pie --with-port=8080 --with-sslport=8443 --with-apr=#{args.prefix} --with-apr=#{arg.prefix} --with-ssl=#{arg.prefix}"

    Rake::Task[:compile].invoke(url, "httpd-#{args.version}.tar.gz", "httpd-#{args.version}", config_flags)
    Rake::Task[:compile].reenable
  end

  task :apr, [:version, :prefix] do |t, args|
    arg.with_defaults(version: '1.7.0')
    url = "https://archive.apache.org/dist/apr/apr-#{arg.version}tar.gz"
    Rake::Task[:compile].invoke(url, "apr-#{arg.version}tar.gz", "apr-#{arg.version}", arg.prefix)
    Rake::Task[:compile].reenable
  end

  task :aprutil, [:version, :prefix] do |t, args|
    arg.with_defaults(version: '1.6.1')
    url = "https://archive.apache.org/dist/apr/apr-util-#{arg.version}.tar.gz"
    config_flags = "--with-apr=#{args.prefix} --with-crypto --without-pgsql --with-openssl=#{arg.prefix}"
    Rake::Task[:compile].invoke(url, "apr-#{arg.prefix}tar.gz", "apr-#{arg.prefix}", arg.prefix, config_flags)
    Rake::Task[:compile].reenable

  end

  task :openssl, [:version, :prefix] do |t, args|
    args.with_defaults(version: '1.1.1d')
    url = "https://www.openssl.org/source/openssl-#{args.version}.tar.gz"
  end

  task :pcre, [:version, :prefix] do |t, args|
    url = "https://ftp.pcre.org/pub/pcre/pcre-#{args.version}.tar.gz"
    config_flags = "-disable-dependency-tracking --enable-utf8 --enable-pcre8 --enable-pcre16 --enable-pcre32 --enable-unicode-properties --enable-pcregrep-libz --enable-pcregrep-libbz2 --enable-jit"
    Rake::Task[:compile].invoke(url, "pcre-#{args.version}.tar.gz", "pcre-#{args.version}", args.prefix, config_flags)
    Rake::Task[:compile].reenable
  end
end
