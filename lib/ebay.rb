# frozen_string_literal: true

require 'ebay/config'
require 'ebay/finding'
require 'ebay/merchandising'
require 'ebay/shopping'

# Ruby wrapper to the eBay APIs
module Ebay
  def self.configure
    yield Config
  end
end
