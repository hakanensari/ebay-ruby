require 'ebay/request'

module Ebay
  class Product < Request
    def initialize
      @host = 'svcs.ebay.com'
      @path = '/services/marketplacecatalog/ProductService/v1'
      @sandbox = 'svcs.sandbox.ebay.com'
      @defaults = {
        headers: {
          'X-EBAY-SOA-SECURITY-APPNAME' => Config.app_id
        }
      }
    end
  end
end
