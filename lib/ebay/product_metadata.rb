require 'ebay/request'

module Ebay
  class ProductMetadata < Request
    def initialize
      @host = 'svcs.ebay.com'
      @path = '/services/marketplacecatalog/ProductMetadataService/v1'
      @sandbox = 'svcs.sandbox.ebay.com'
      @defaults = {
        headers: {
          'X-EBAY-SOA-SECURITY-APPNAME' => Config.app_id
        }
      }
    end
  end
end
