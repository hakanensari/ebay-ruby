# frozen_string_literal: true

require 'ebay/request'

module Ebay
  class Finding < Request
    host { 'svcs.ebay.com' }
    path { '/services/search/FindingService/v1' }
    headers { { 'X-EBAY-SOA-SECURITY-APPNAME' => Config.app_id } }
  end
end
