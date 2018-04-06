Pod::Spec.new do |s|
  s.name         = "PWSDKTester"
  s.version      = "3.3.3"
  s.summary      = "Phunware PWSDKTester for iOS."
  s.homepage     = "http://phunware.github.io/maas-test-ios-sdk/"
  s.author       = { 'Phunware, Inc.' => 'http://www.phunware.com' }
  s.social_media_url = 'https://twitter.com/Phunware'

  s.platform     = :ios, '9.0'
  s.source       = { :git => "https://github.com/phunware/maas-test-ios-sdk.git", :tag => "v3.3.3" }
  s.license      = { :type => 'Copyright', :text => 'Copyright 2015 by Phunware Inc. All rights reserved.' }

  s.libraries 	 = 'z', 'xml2.2'
  s.ios.dependency 'SSZipArchive'
  s.ios.dependency 'AFNetworking'
  s.ios.dependency 'TMCache'
                  
  s.ios.vendored_frameworks = 'Framework/PWCore.framework'
  s.ios.frameworks = 'Security', 'QuartzCore', 'SystemConfiguration', 'MobileCoreServices', 'CoreTelephony'
  s.requires_arc = true
end
