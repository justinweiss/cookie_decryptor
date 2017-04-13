# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cookie_decryptor/version'

Gem::Specification.new do |spec|
  spec.name          = "cookie_decryptor"
  spec.version       = CookieDecryptor::VERSION
  spec.authors       = ["Justin Weiss"]
  spec.email         = ["justin@justinweiss.com"]

  spec.summary       = "Decrypt your secure Rails cookies."
  spec.description   = "Ever wanted to peek inside your signed, encrypted Rails cookies? With this gem, it's easy."
  spec.homepage      = "https://github.com/justinweiss/cookie_decryptor"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 4.0.0"
  
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
