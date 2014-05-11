require 'ebay/request'

module Ebay
  class Merchandising < Request
    def initialize
      @host = 'svcs.ebay.com'
      @path = '/MerchandisingService'
      @sandbox = 'svcs.sandbox.ebay.com'
      @defaults = {
        headers: {
          'EBAY-SOA-CONSUMER-ID' => Config.app_id
        }
      }
    end
  end
end
