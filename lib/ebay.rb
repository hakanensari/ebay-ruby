# frozen_string_literal: true

require 'ebay/config'
require 'ebay/finding'
require 'ebay/merchandising'
require 'ebay/product'
require 'ebay/product_metadata'
require 'ebay/shopping'

module Ebay
  def self.configure
    yield Config
  end
end
