require 'ebay/request'

module Ebay
  class Shopping < Request
    def initialize
      @host = 'open.api.ebay.com'
      @path = '/shopping'
      @sandbox = 'open.api.sandbox.ebay.com'
      @defaults = {
        headers: {
          'X-EBAY-API-APP-ID' => Config.app_id,
          'X-EBAY-API-VERSION' => 799
        }
      }
    end
  end
end
