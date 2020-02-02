namespace :gcc do
  task :gcc, [:version, :prefix] do |t, args|
    args.with_defaults(version: '9.2.0', prefix: '/usr/local/gcc')
    prefix = args.prefix
    url = "https://ftpmirror.gnu.org/gcc/gcc-9.2.0/gcc-9.2.0.tar.xz"
    package_name = 'gcc-9.2.0'
    file_name = File.basename(url)
    sh 'mkdir gcc-build'
    sh "curl -OJL #{url} && mkdir -p #{package_name} && tar -xf #{file_name} -C #{package_name} --strip-component=1"
    sh "#{package_name}/contrib/download_prerequisites"
    sh "cd gcc-build && ../#{package_name}/configure --prefix=#{prefix} --disable-multilib && make && make install"

    sh "tar -zcvfC gcc-#{args.version}.tar.gz /usr/local gcc"
  end
end
