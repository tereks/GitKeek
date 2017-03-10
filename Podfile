platform :ios, '9.0'
use_frameworks!

abstract_target 'Abstract' do
 
  pod 'SwiftRichString'
  pod 'Moya'
  pod 'PromiseKit', '~> 4.0'

  pod 'PTPopupWebView'
  pod 'PKHUD', '~> 4.0'

  pod 'Marshal'

target 'GitKeek'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end