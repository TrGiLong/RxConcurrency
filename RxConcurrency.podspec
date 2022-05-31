Pod::Spec.new do |s|
  s.name             = 'RxConcurrency'
  s.version          = '0.1.1'
  s.summary          = 'A small set of extensions that allow to combine new swift concurrency with RxSwift.'

  s.description      = <<-DESC
    A small set of extensions that allow to combine new swift concurrency with RxSwift.

    This package is actively under development. I appreciate any code improvements or new features.
                       DESC

  s.homepage         = 'https://github.com/TrGiLong/RxConcurrency'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Long Tran' => 'trangianglong4003@gmail.com' }
  s.source           = { :git => 'git@github.com:TrGiLong/RxConcurrency.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'Sources/RxConcurrency/**/*'
  s.swift_version = '5.5'

  s.pod_target_xcconfig = {
    'SWIFT_OPTIMIZATION_LEVEL' => '-O'
  }

  s.dependency 'RxSwift', '~> 6.5.0'
end