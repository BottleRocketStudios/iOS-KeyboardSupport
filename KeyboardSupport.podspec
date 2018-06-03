#
# Be sure to run `pod lib lint KeyboardSupport.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'KeyboardSupport'
s.version          = '1.0.0'
s.summary          = 'Makes dealing with common keyboard tasks simpler and easier.'

s.description      = <<-DESC
KeyboardSupport provides easy navigation between text fields via your custom views and/or with the keyboard's "Return" key. Protocols are provided for easy keyboard dismissal and scrolling when using a UIScrollView.
                        DESC

s.homepage         = 'https://github.com/BottleRocketStudios/iOS-KeyboardSupport'
s.license          = { :type => 'Apache', :file => 'LICENSE' }
s.author           = { 'Bottle Rocket Studios' => 'earl.gaspard@bottlerocketstudios.com' }
s.source           = { :git => 'https://github.com/bottlerocketstudios/iOS-KeyboardSupport.git', :tag => s.version.to_s }

s.ios.deployment_target = '9.0'
s.source_files = 'Sources/KeyboardSupport/*'
s.frameworks = 'Foundation', 'UIKit'

end
