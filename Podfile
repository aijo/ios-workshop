source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'ios' do    
    pod 'Alamofire', '~> 4.0'
    pod 'ObjectMapper',
        :git => 'https://github.com/Hearst-DD/ObjectMapper.git',
        :branch => 'swift-3'
#    pod 'SwiftyJSON',
#        :git => 'https://github.com/SwiftyJSON/SwiftyJSON.git',
#        :branch => 'swift3'
    pod 'DateTools', '~> 1.7'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
