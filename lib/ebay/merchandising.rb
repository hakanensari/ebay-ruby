require 'ebay/request'

module Ebay
  class Merchandising < Request
    host 'svcs.ebay.com'
    path '/MerchandisingService'
    headers 'EBAY-SOA-CONSUMER-ID' => Config.app_id
  end
end
