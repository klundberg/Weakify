
Pod::Spec.new do |s|
  s.name             = "Weakify"
  s.version          = "0.1.0"
  s.summary          = "A short description of Weakify."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/klundberg/Weakify"
  s.license          = 'MIT'
  s.author           = { "Kevin Lundberg" => "kevin@klundberg.com" }
  s.source           = { :git => "https://github.com/klundberg/Weakify.git", :tag => "v#{s.version}" }
  s.social_media_url = 'https://twitter.com/kevlario'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Weakify/**/*'
end
