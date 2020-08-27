# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = "toy-robot"
  spec.version = "0.0.1"
  spec.authors = ["Salman Sohail"]
  spec.date = "2020-08-27"
  spec.summary = "Ruby gem for Toy Robot test"
  spec.description = "Let the Toy Robot move onto the table without dying."
  spec.email = "salmansohail@agilis-lab.com"
  spec.homepage = "https://github.com/saluminati/toy-robot"
  spec.licenses = ["MIT"]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.3.0'

  spec.files         = Dir["README.md", "lib/**/*.rb"]
  spec.test_files    = Dir["spec/**/*.rb"]
end
