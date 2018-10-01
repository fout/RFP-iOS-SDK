Pod::Spec.new do |s|
  s.name         = "RFP-iOS-SDK"
  s.version      = "2.8.1"
  s.summary      = "RFP SDK for iOS"
  s.homepage     = "https://github.com/fout/RFP-iOS-SDK"
  s.license      = {
    :type => 'Commercial',
    :text => <<-LICENSE
      Copyright© FreakOut Inc., All Rights Reserved.
    LICENSE
  }
  s.author       = "FreakOut Inc."

  s.platform     = :ios
  s.source = {
      :git => "https://github.com/fout/RFP-iOS-SDK.git",
      :tag => "v#{s.version}"
  }
  s.vendored_frameworks = 'RFP.framework'

  s.frameworks = 'AdSupport'
  s.compiler_flags = '-ObjC'
  s.requires_arc = true
end
