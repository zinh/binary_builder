namespace :emacs do
  prefix = "/usr/local/emacs"

  task :emacs, [:version] => [:gnutls, :jasson] do |t, args|
    config_flags = <<~END
    --disable-silent-rules 
    --without-x 
    --with-gnutls 
    --with-xml2 
    --without-ns 
    --with-modules 
    --prefix=$HOME/Programs/emacs-25.3
    END
    Rake::Task[:compile].invoke('http://mirrors.syringanetworks.net/gnu/emacs/emacs-26.3.tar.xz', 'emacs-26.3')
  end

  task :gnutls => [:libtasn1, :gmp, :libunistring, :nettle] do |t, args|
    config_flags = <<~END
  --disable-dependency-tracking 
  --disable-silent-rules 
  --disable-static 
  --sysconfdir=/usr/local/etc 
  --with-default-trust-store-file=/usr/local/etc/openssl/cert.pem 
  --disable-heartbeat-support 
  --without-p11-kit
    END
    Rake::Task[:compile].invoke('https://www.gnupg.org/ftp/gcrypt/gnutls/v3.5/gnutls-3.5.19.tar.xz', 'gnutls-3.5.19', config_flags)
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
    Rake::Task[:compile].invoke('https://ftp.gnu.org/gnu/libunistring/libunistring-0.9.10.tar.xz', 'libunistring-0.9.10', prefix, '--disable-dependency-tracking --disable-silent-rules')
    Rake::Task[:compile].reenable
  end

  task :nettle do
    Rake::Task[:compile].invoke('https://ftp.gnu.org/gnu/nettle/nettle-3.4.tar.gz', 'nettle-3.4', prefix, '--disable-dependency-tracking --enable-shared --with-include-path=emacs/include --with-lib-path=emacs/lib')
    Rake::Task[:compile].reenable
  end

  task :jasson do
    Rake::Task[:compile].invoke('http://www.digip.org/jansson/releases/jansson-2.12.tar.gz', 'jansson-2.12', prefix)
    Rake::Task[:compile].reenable
  end
end