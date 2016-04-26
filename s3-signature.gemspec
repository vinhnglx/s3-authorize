# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 's3/signature/version'

Gem::Specification.new do |spec|
  spec.name          = "s3-signature"
  spec.version       = S3::Signature::VERSION
  spec.authors       = ["Vinh Nguyen"]
  spec.email         = ["vinh.nglx@gmail.com"]

  spec.summary       = %q{Generate Signature and Policy for upload any files to S3.}
  spec.description   = %q{Gem generates a signature and policy from AWS Secret key.}
  spec.homepage      = "https://github.com/vinhnglx/s3-signature"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
