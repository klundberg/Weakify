
Pod::Spec.new do |s|
  s.name             = "Weakify"
  s.version          = "0.1.2"
  s.summary          = "A set of functions that allow you to weakly apply an object to a method so that it can be used without causing memory leaks."

  s.description      = <<-DESC
                        Weakify is a µframework providing some commonly useful variations of the weakify() function. weakify() is primarily a way to be able to use a method on a class as a closure value that would be managed by some other component, but in a way that prevents memory leaks from occurring.
                       DESC

  s.homepage         = "https://github.com/klundberg/Weakify"
  s.license          = 'MIT'
  s.author           = { "Kevin Lundberg" => "kevin@klundberg.com" }
  s.source           = { :git => "https://github.com/klundberg/Weakify.git", :tag => "v#{s.version}" }
  s.social_media_url = 'https://twitter.com/kevlario'

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"

  s.requires_arc = true

  s.source_files = 'Weakify/*.swift'
end
