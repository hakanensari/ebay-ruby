require 'delegate'
require 'json'
require 'multi_xml'

module Ebay
  class Parser < SimpleDelegator
    def parse
      if headers['Content-Type'].include?('xml')
        MultiXml.parse(body)
      else
        JSON.parse(body)
      end
    end
  end
end
