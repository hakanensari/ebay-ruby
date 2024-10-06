# frozen_string_literal: true

$LOAD_PATH.push(File.expand_path("lib", __dir__))
require "ebay/version"

Gem::Specification.new do |gem|
  gem.name     = "ebay-ruby"
  gem.version  = Ebay::VERSION
  gem.authors  = ["Hakan Ensari"]
  gem.email    = ["hakanensari@gmail.com"]
  gem.homepage = "https://github.com/hakanensari/ebay-ruby"
  gem.summary  = "Ruby wrapper to the eBay APIs"
  gem.license  = "MIT"

  gem.files = Dir.glob("lib/**/*") + ["LICENSE", "README.md"]

  gem.add_dependency("http", ">= 5.0")
  gem.required_ruby_version = ">= 3.2"
  gem.metadata["rubygems_mfa_required"] = "true"
end
