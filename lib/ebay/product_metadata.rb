# frozen_string_literal: true

require 'ebay/request'

module Ebay
  class ProductMetadata < Request
    host { 'svcs.ebay.com' }
    path { '/services/marketplacecatalog/ProductMetadataService/v1' }
    headers { { 'X-EBAY-SOA-SECURITY-APPNAME' => Config.app_id } }
  end
end
