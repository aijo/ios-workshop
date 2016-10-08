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
    pod 'DZNEmptyDataSet', '~> 1.8'
#    pod 'StatusProvider',
#        :git => 'https://github.com/mariohahn/StatusProvider.git',
#        :commit => '45096c8916d96c3e6c74ec381e154b4e66a0cfc6'
    pod 'RxSwift',    '3.0.0-beta.2'
    pod 'RxCocoa',    '3.0.0-beta.2'
end

target 'iosTests' do
    pod 'RxBlocking', '3.0.0-beta.2'
    pod 'RxTests',    '3.0.0-beta.2'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
