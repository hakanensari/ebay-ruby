# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'ebay/version'

Gem::Specification.new do |gem|
  gem.name     = 'ebay-ruby'
  gem.version  = Ebay::VERSION
  gem.authors  = ['Hakan Ensari']
  gem.email    = ['me@hakanensari.com']
  gem.homepage = 'https://github.com/hakanensari/ebay-ruby'
  gem.summary  = 'Ruby wrapper to the eBay APIs'
  gem.license  = 'MIT'

  gem.files = Dir.glob('lib/**/*') + %w[LICENSE README.md]

  gem.add_dependency 'http', '~> 4.0'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'redcarpet'
  gem.add_development_dependency 'rubocop'
  gem.add_development_dependency 'rubocop-minitest'
  gem.add_development_dependency 'rubocop-rake'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'yard'
  gem.required_ruby_version = '>= 2.5'
end
