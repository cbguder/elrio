# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "elrio/version"

Gem::Specification.new do |spec|
  spec.name          = "elrio"
  spec.version       = Elrio::VERSION
  spec.authors       = ["Can Berk Güder"]
  spec.email         = ["cbguder@gmail.com"]
  spec.description   = "Cap inset detector & optimizer for resizable UIKit assets."
  spec.summary       = "Cap inset detector & optimizer for resizable UIKit assets."
  spec.homepage      = "https://github.com/cbguder/elrio"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "chunky_png"
end
