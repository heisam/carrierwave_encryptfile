# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carrierwave_encryptfile/version'

Gem::Specification.new do |gem|
  gem.name          = "carrierwave_encryptfile"
  gem.version       = "0.1.1"
  gem.version       = CarrierwaveEncryptfile::VERSION
  gem.authors       = ["Heiner Sameisky"]
  gem.email         = ["hei.sam@gmail.com"]
  gem.description   = "Encrypted file uploads with CarrierWave"
  gem.summary       = "Encrypted file uploads with CarrierWave"
  gem.homepage      = "http://github.com/heisam/carrierwave_encryptfile"
  gem.licenses      = ["MIT"]

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('carrierwave')
  #gem.add_dependency('gibberish2')
  gem.add_development_dependency('rspec')
end
