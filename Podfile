platform :ios, '9.0'
use_frameworks!

target 'RxSwiftAlamofire' do

pod 'RxAlamofire/RxCocoa', '~> 3.0.0'
pod 'ObjectMapper', '~> 2.2.0'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.name == 'Debug'
                config.build_settings['ENABLE_TESTABILITY'] = 'YES'
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end
end
