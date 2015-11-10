Pod::Spec.new do |s|
  s.name     = 'ObjectiveSpark'
  s.version  = '1.0.3'
  s.license  = 'MIT'
  s.summary  = 'ObjectiveSpark is an Objective-C API for interacting with a Spark Core.'
  s.homepage = 'https://github.com/edc1591/ObjectiveSpark'
  s.authors  = { 'Evan Coleman' => 'evan@edc.me' }
  s.social_media_url = 'https://twitter.com/edc1591'
  s.source   = { :git => 'https://github.com/edc1591/ObjectiveSpark.git', :tag => '1.0.3' }
  s.requires_arc = true
  
  s.ios.deployment_target = '7.0'
  
  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |ss|
    ss.dependency 'AFNetworking', '~> 2.0'
    
    ss.public_header_files = 'ObjectiveSpark/*.h'
    ss.source_files = 'ObjectiveSpark/ObjectiveSpark.h', 'ObjectiveSpark/OSAPIClient.{h,m}'
    ss.frameworks = 'Foundation'
  end

  s.subspec 'ReactiveCocoa' do |ss|
    ss.dependency 'ObjectiveSpark/Core'
    ss.dependency 'ReactiveCocoa'
    
    ss.public_header_files = 'ReactiveCocoa+ObjectiveSpark/*.h'
    ss.source_files = 'ReactiveCocoa+ObjectiveSpark/ReactiveCocoa+ObjectiveSpark.h', 'ReactiveCocoa+ObjectiveSpark/OSAPIClient+RACSupport.{h,m}'
  end

end
