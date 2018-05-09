lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alipay2/version'

Gem::Specification.new do |s|
  s.name          = 'alipay2'
  s.version       = Alipay2::VERSION
  s.authors       = ['qinmingyuan']
  s.email         = ['mingyuan0715@foxmail.com']
  s.description   = %q{An unofficial simple alipay gem}
  s.summary       = %q{An unofficial simple alipay gem}
  s.homepage      = "https://github.com/qinmingyuan/alipay2"
  s.license       = "MIT"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|s|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
  s.add_development_dependency "minitest"
  s.add_development_dependency "webmock"
end
