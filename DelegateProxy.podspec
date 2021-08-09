Pod::Spec.new do |spec|
  spec.name = 'DelegateProxy'
  spec.version  = '1.2.0'
  spec.author = { 'Tema.Tian' => 'temagsoft@163.com' }
  spec.homepage = 'https://github.com/orchid-bloom'
  spec.summary = 'Proxy for receive delegate events more practically'
  spec.source = { :git => 'https://github.com/orchid-bloom/DelegateProxy.git', :branch => 'master' }
  spec.license = { :type => 'MIT', :file => 'LICENSE.md' }
  spec.source_files = 'Sources/**/*.{h,m,swift}'
  spec.requires_arc = true
  spec.osx.deployment_target = '13.0'
  spec.ios.deployment_target = '13.0'
  spec.tvos.deployment_target = "13.0"
end
