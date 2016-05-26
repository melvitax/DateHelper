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
  s.version          = "3.4.0"
  s.summary          = "NSDate Extension for Swift 2.0"
  s.description      = <<-DESC
                       Extension for NSDate in Swift for creating, modifying or comparing dates.
                       DESC
  s.homepage         = "https://github.com/melvitax/AFDateHelper"
  s.screenshots      = "https://raw.githubusercontent.com/melvitax/AFDateHelper/master/Screenshot.png"
  s.license          = 'MIT'
  s.author           = { "Melvin Rivera" => "melvin@allforces.com" }
  s.source           = { :git => "https://github.com/melvitax/AFDateHelper.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/melvitax'

  s.platforms     = { :ios => '8.0', :tvos => '9.0' }
  s.requires_arc = true

  s.source_files = 'AFDateHelper/**/*'
  #s.resource_bundles = {}

  # s.public_header_files
  # s.frameworks
  # s.dependency 
end
