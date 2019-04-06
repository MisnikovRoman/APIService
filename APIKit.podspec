Pod::Spec.new do |s|
	s.name         = "APIKit"
	s.version      = "0.0.2"
	s.platform     = :ios, "12.0"
 	s.swift_version = '4.0'
	s.summary      = "Simple and lightweight API service framework"

	s.description  = "Simple and lightweight API service framework from Misnikov Roman"
	s.homepage     = "https://github.com/MisnikovRoman/APIService"
	s.license      = "MIT"
	s.author       = { "Misnikov Roman" => "misnikovroman@gmail.com" }
	s.source       = { :git => "https://github.com/MisnikovRoman/APIService.git", :tag => "#{s.version}" }
	s.source_files  = "APIKit", "APIKit/**/*.{h,m,swift}"
end
