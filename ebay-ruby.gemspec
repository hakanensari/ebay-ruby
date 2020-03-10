require 'ebay/version'
# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'ebay-ruby'
  s.version     = Ebay::VERSION
  s.authors     = ['Hakan Ensari']
  s.email       = ['me@hakanensari.com']
  s.homepage    = 'https://github.com/hakanensari/ebay-ruby'
  s.summary     = 'A Ruby wrapper to the eBay Web Services API'
$LOAD_PATH.push File.expand_path('lib', __dir__)

  s.add_dependency 'excon', '~>0.33'
  s.add_dependency 'multi_xml', '>= 0.5.5'

  s.add_development_dependency 'rake', '~> 10.3'
  s.add_development_dependency 'minitest', '~> 5.3'
  s.add_development_dependency 'vcr', '~> 2.9'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']
end
