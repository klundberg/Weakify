workspace 'Weakify'
use_frameworks!

def test_pods
    pod 'Nimble', '~> 3.2.0'
    pod 'Quick', '~> 0.9.1'
end

target :ios do
    link_with 'Weakify-iOSTests'
    platform :ios, '8.0'
    test_pods
end

target :osx do
    link_with 'Weakify-OSXTests'
    platform :osx, '10.9'
    test_pods
end

target :tvos do
    link_with 'Weakify-tvOSTests'
    platform :tvos, '9.0'
    test_pods
end
