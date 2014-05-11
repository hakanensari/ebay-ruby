require 'ebay/config'

module Ebay
  def self.configure
    yield Config
  end
end
