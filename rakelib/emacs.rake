namespace :emacs do
  prefix = "/usr/local/emacs"

  task :emacs, [:version] => [:gnutls, :jasson, :lcms] do |t, args|
    Rake::Task[:libxml2].invoke(prefix)
    config_flags = "--disable-silent-rules --without-x --with-gnutls --with-xml2 --without-ns --with-modules"
    env = {
      'CPPFLAGS' => "-I#{prefix}/include",
      'PKG_CONFIG_PATH' => "#{prefix}/lib/pkgconfig",
      'LDFLAGS' => "-L#{prefix}/lib"
    }
    Rake::Task[:compile].invoke('http://mirrors.syringanetworks.net/gnu/emacs/emacs-26.3.tar.xz', 'emacs-26.3', prefix, config_flags, env)
    sh 'tar -zcf emacs.tar.gz /usr/local/emacs'
  end

  task :gnutls => [:libtasn1, :gmp, :libunistring, :nettle] do |t, args|
    config_flags = "--disable-silent-rules --disable-static --sysconfdir=/usr/local/etc --with-default-trust-store-file=/usr/local/etc/openssl/cert.pem --disable-heartbeat-support --without-p11-kit --with-libunistring-prefix=#{prefix}"
    env = {
      'CPPFLAGS' => "-I#{prefix}/include",
      'PKG_CONFIG_PATH' => "#{prefix}/lib/pkgconfig",
      'LDFLAGS' => "-L#{prefix}/lib"
    }
    Rake::Task[:compile].invoke('https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-3.6.12.tar.xz', 'gnutls-3.6.12', prefix, config_flags, env)
    Rake::Task[:compile].reenable
  end

  task :libtasn1 do |t, args|
    Rake::Task[:compile].invoke('https://ftp.gnu.org/gnu/libtasn1/libtasn1-4.13.tar.gz', 'libtasn1-4.13', prefix)
    Rake::Task[:compile].reenable
  end

  task :gmp do |t, args|
    Rake::Task[:compile].invoke('https://gmplib.org/download/gmp/gmp-6.1.2.tar.xz', 'gmp-6.1.2', prefix, '-enable-cxx --with-pic')
    Rake::Task[:compile].reenable
  end

  task :libunistring do
    Rake::Task[:compile].invoke('https://ftp.gnu.org/gnu/libunistring/libunistring-0.9.10.tar.xz', 'libunistring-0.9.10', prefix)
    Rake::Task[:compile].reenable
  end

  task :nettle do
    Rake::Task[:compile].invoke('https://ftp.gnu.org/gnu/nettle/nettle-3.4.1.tar.gz', 'nettle-3.4.1', prefix, "--with-include-path=#{prefix}/include --with-lib-path=#{prefix}/lib")
    Rake::Task[:compile].reenable
  end

  task :jasson do
    Rake::Task[:compile].invoke('http://www.digip.org/jansson/releases/jansson-2.12.tar.gz', 'jansson-2.12', prefix)
    Rake::Task[:compile].reenable
  end

  task :lcms do
    Rake::Task[:compile].invoke('http://archive.ubuntu.com/ubuntu/pool/main/l/lcms2/lcms2_2.9.orig.tar.gz', 'lcms2-2.9', prefix)
    Rake::Task[:compile].reenable
  end
end
