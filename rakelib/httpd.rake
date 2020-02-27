namespace :httpd do
  task :httpd, [:version, :prefix] do |t, args|
    default_version =  '2.4.41'
    default_prefix =  "/usr/local/httpd-#{default_version}"

    args.with_defaults(version: '2.4.41', prefix: default_prefix)
    url = "https://archive.apache.org/dist/httpd/httpd-#{args.version}.tar.gz"
    config_flags = ""

    Raks::Task[:compile].invoke(url, "httpd-#{args.version}.tar.gz", "httpd-#{args.version}", config_flags)
    Rake::Task[:compile].reenable
  end

  task :apr, [:version, :prefix] do |t, args]
  end

  task :aprutil, [:version, :prefix] do |t, args]
  end

  task :openssl, [:version, :prefix] do |t, args|
  end

  task :pcre, [:version, :prefix] do |t, args|
    url = "https://ftp.pcre.org/pub/pcre/pcre-#{args.version}.tar.gz"
    config_flags = "-disable-dependency-tracking --enable-utf8 --enable-pcre8 --enable-pcre16 --enable-pcre32 --enable-unicode-properties --enable-pcregrep-libz --enable-pcregrep-libbz2 --enable-jit"
    Rake::Task[:compile].invoke(url, "pcre-#{args.version}.tar.gz", "pcre-#{args.version}", args.prefix, config_flags)
    Rake::Task[:compile].reenable
  end
end
