platform :ios, '10.0'
use_frameworks!

abstract_target 'Abstract' do
 
  pod 'SwiftRichString', '1.1.0'
  pod 'Moya', '11.0.0'
  pod 'PromisesSwift', '1.0.3'

  pod 'PKHUD'

  pod 'Marshal'
  pod 'Cartography'
  pod 'Kingfisher'

target 'GitKeek'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.0'
    end
  end
end
