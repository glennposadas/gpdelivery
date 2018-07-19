project 'GPDelivery/GPDelivery.xcodeproj'

source 'https://github.com/CocoaPods/Specs'

platform :ios, '9.0'
use_frameworks!

# ignore all warnings from all pods, since Xcode is beta
inhibit_all_warnings!

  target 'GPDelivery' do
    
    pod 'Kingfisher'                    # Image loading with built-in caching system.
    pod 'Moya'                          # Networking Abstraction Layer
    pod 'SnapKit'                       # Constraint Programmatically.
    pod 'SwiftyJSON'                    # Parsing of JSON Data
   
    target 'GPDeliveryTests' do
        pod 'Moya'
        pod 'SwiftyJSON'
    end

    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end

  end

  target 'GPDeliveryUITests' do

  end
