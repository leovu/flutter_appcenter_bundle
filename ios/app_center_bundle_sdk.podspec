#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_appcenter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_appcenter'
  s.version          = '0.0.2'
  s.summary          = 'A Bundle for App Center SDK'
  s.description      = <<-DESC
A Bundle for App Center SDK
                       DESC
  s.homepage         = 'https://github.com/vincenzosarnataro'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Vincenzo Sarnataro' => 'sarnataro.vincenzo@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'AppCenter'
  s.dependency 'AppCenter/Distribute'
  s.platform = :ios, '9.0'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
