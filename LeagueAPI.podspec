#
# Be sure to run `pod lib lint LeagueAPI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LeagueAPI'
  s.version          = '0.1'
  s.summary          = 'LeagueAPI is a simple Swift League of Legends API wrapper'

  s.description      = <<-DESC
  LeagueAPI is designed to be used in Swift projects to simplify accessing to League of Legends API
                       DESC

  s.homepage         = 'https://github.com/mathmatrix828/LeagueAPI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mason Phillips' => 'math.matrix.tumblr@gmail.com' }
  s.source           = { :git => 'https://github.com/mathmatrix828/LeagueAPI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LeagueAPI/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LeagueAPI' => ['LeagueAPI/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'SwiftyJSON'
  s.dependency 'Alamofire'
  s.dependency 'Datez'
end
