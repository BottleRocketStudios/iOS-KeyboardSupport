#
# Be sure to run `pod lib lint KeyboardSupport.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'KeyboardSupport'
s.version          = '2.0.0'
s.summary          = 'Makes dealing with common keyboard tasks simpler and easier.'

s.description      = <<-DESC
KeyboardSupport makes it easy to automatically handle keyboard dismissal and scrolling to the active text input. With a few lines of code, it’s also easy to implement navigation between text inputs via toolbar back/next buttons or the keyboard’s “Return” key.
                        DESC

s.homepage         = 'https://github.com/BottleRocketStudios/iOS-KeyboardSupport'
s.license          = { :type => 'Apache', :file => 'LICENSE' }
s.author           = { 'Bottle Rocket Studios' => 'earl.gaspard@bottlerocketstudios.com' }
s.source           = { :git => 'https://github.com/bottlerocketstudios/iOS-KeyboardSupport.git', :tag => s.version.to_s }

s.ios.deployment_target = '9.0'
s.source_files = 'Sources/KeyboardSupport/*'
s.frameworks = 'Foundation', 'UIKit'

end
