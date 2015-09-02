require 'ebay/request'

module Ebay
  class Product < Request
    host 'svcs.ebay.com'
    path '/services/marketplacecatalog/ProductService/v1'
    headers 'X-EBAY-SOA-SECURITY-APPNAME' => Config.app_id
  end
end
