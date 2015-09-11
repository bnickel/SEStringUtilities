Pod::Spec.new do |s|

  s.name         = "SEStringUtilities"
  s.version      = "0.2.0"
  s.summary      = "A few simple string replacement utilities."

  s.homepage     = "https://github.com/bnickel/SEStringUtilities"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Brian Nickel" => "bnickel@stackexchange.com" }
  
  s.source       = { :git => "https://github.com/bnickel/SEStringUtilities.git", :tag => "v#{s.version}" }

  s.source_files = "SEStringUtilities"
  s.public_header_files = "SEStringUtilities/**/*.h"

  s.frameworks = "Foundation"

  s.requires_arc = true
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'

end
