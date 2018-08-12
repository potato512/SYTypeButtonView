Pod::Spec.new do |s|
  s.name         = "SYTypeButtonView"
  s.version      = "2.1.0"
  s.summary      = "SYTypeButtonView used to show button view..."
  s.homepage     = "https://github.com/potato512/SYTypeButtonView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "herman" => "zhangsy757@163.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/potato512/SYTypeButtonView.git", :tag => "#{s.version}" }
  s.source_files  = "SYTypeButtonView/*.{h,m}"
  s.frameworks   = "UIKit", "Foundation"
  s.requires_arc = true
end
