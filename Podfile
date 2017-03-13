platform :ios, '9.0'
use_frameworks!

abstract_target 'Abstract' do
 
  pod 'SwiftRichString'
  pod 'Moya', '~> 8.0'
  pod 'PromiseKit', '~> 4.0'

  pod 'PTPopupWebView', '~> 0.4.0'
  pod 'PKHUD', '~> 4.0'

  pod 'Marshal', '~> 1.0'
  pod 'Cartography', '~> 1.0'
  pod 'Kingfisher', '~> 3.0'

target 'GitKeek'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end