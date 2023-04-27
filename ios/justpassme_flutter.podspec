#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint justpassme_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'justpassme_flutter'
  s.version          = '0.0.1'
  s.summary          = 'A passkey auth SDK for Flutter.'
  s.description      = <<-DESC
A passkey auth SDK for Flutter.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '16.2'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  s.preserve_paths = 'JustPassMeFramework.xcframework/**/*'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework JustPassMeFramework' }
  s.vendored_frameworks = 'JustPassMeFramework.xcframework'
end
