
Pod::Spec.new do |s|
  s.name         = "WQRefresh"
  s.version      = "1.0.0"
  s.summary      = "A plug-in that combine with the drop-down refresh and pull on loading"

  s.description  = <<-DESC
  A plug-in that combine with the drop-down refresh and pull on loading,it can let your drop-down refresh and pull on loading more easy
                   DESC

  s.homepage     = "https://github.com/AppleDP/WQRefresh"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "AppleDP" => "AppleDP@163.com" }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source       = { :git => "https://github.com/AppleDP/WQRefresh.git", :tag => s.version }

  s.source_files  = "WQRefresh/**/WQRefresh/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
end
