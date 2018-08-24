Pod::Spec.new do |s|
  s.name             = "AFDateHelper"
  s.version          = "4.2.8"
  s.summary          = "Date Extension for Swift 4.0"
  s.description      = <<-DESC
                       A Swift Date extension for creating, modifying and comparing dates.
                       DESC
  s.homepage         = "https://github.com/melvitax/DateHelper"
  s.screenshots      = "https://raw.githubusercontent.com/melvitax/DateHelper/master/logo.png"
  s.license          = 'MIT'
  s.author           = { "Melvin Rivera" => "melvitax@me.com" }

  s.social_media_url = 'https://twitter.com/melvitax'

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.ios.deployment_target = "9.0"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.osx.deployment_target = "10.11"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source           = { :git => "https://github.com/melvitax/DateHelper.git", :tag => s.version.to_s }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files = "Sources/**/*.swift"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.requires_arc = true
  s.pod_target_xcconfig  = { 'SWIFT_VERSION' => '4.0' }

end
