require 'ebay/request'

module Ebay
  class Finding < Request
    def initialize
      @host = 'svcs.ebay.com'
      @path = '/services/search/FindingService/v1'
      @sandbox = 'svcs.sandbox.ebay.com'
      @defaults = {
        headers: {
          'X-EBAY-SOA-SECURITY-APPNAME' => Config.app_id
        }
      }
    end
  end
end
