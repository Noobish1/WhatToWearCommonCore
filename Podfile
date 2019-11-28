source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

def debug_pods
    pod 'SwiftLint', '0.37.0', :configurations => 'Debug'
end

def testing_pods
    pod 'Quick', '2.2.0'
    pod 'Nimble', '8.0.4'
end

target 'WhatToWearCommonCore' do
    platform :ios, '10.0'
    
    debug_pods
    
    target 'WhatToWearCommonCoreTests' do
        inherit! :search_paths
        testing_pods
    end
end

target 'WhatToWearCommonCore-Mac' do
    platform :osx, '10.14'
    
    debug_pods
    
    target 'WhatToWearCommonCore-MacTests' do
        inherit! :search_paths
        testing_pods
    end
end
