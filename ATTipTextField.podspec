Pod::Spec.new do |s|

  s.name         = "ATTipTextField"
  s.version      = "1.0.0"
  s.summary      = "A UITextField subclass that can drop down a customizable message."
  s.description  = "A UITextField subclass that can show a customizable tip message underneath. Good for data validation UI." 
  s.homepage     = "https://github.com/atecle/ATTipTextField"
  s.license      = "MIT"
  s.author       = { "Adam" => "adam.tecle@gmail.com" }
  s.social_media_url   = "http://twitter.com/admtcl"
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/atecle/ATTipTextField.git", :tag => "#{s.version}" }
  s.source_files  = "ATTipTextField", "ATTipTextField/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }

end
