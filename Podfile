workspace 'Weakify'
use_frameworks!

def test_pods
    pod 'Nimble', '~> 4.1.0'
    pod 'Quick', '~> 0.9.3'
end

target 'Weakify-iOSTests' do
    platform :ios, '8.0'
    test_pods
end

target 'Weakify-OSXTests' do
    platform :osx, '10.9'
    test_pods
end

target 'Weakify-tvOSTests' do
    platform :tvos, '9.0'
    test_pods
end
