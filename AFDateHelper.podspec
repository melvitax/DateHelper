#
# Be sure to run `pod lib lint AFDateHelper.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AFDateHelper"
  s.version          = "4.2.1"
  s.summary          = "Date Extension for Swift 3.1"
  s.description      = <<-DESC
                       A Swift Date extension for creating, modifying and comparing dates.
                       DESC
  s.homepage         = "https://github.com/melvitax/DateHelper"
  s.screenshots      = "https://raw.githubusercontent.com/melvitax/DateHelper/master/logo.png"
  s.license          = 'MIT'
  s.author           = { "Melvin Rivera" => "melvitax@me.com" }
  s.source           = { :git => "https://github.com/melvitax/DateHelper.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/melvitax'

  s.platforms     = { :ios => '8.0', :tvos => '9.0',  :watchos => '2.0', :osx => '10.12' }
  s.ios.deployment_target = "8.0"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.osx.deployment_target = "10.12"

  s.xcconfig = { 'SWIFT_VERSION' => '3.1' }

s.source_files = "Sources/**/*.{h,swift}"

end
