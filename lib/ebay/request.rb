require 'excon'
require 'ebay/config'
require 'ebay/parser'

module Ebay
  class Request
    %i(host path headers).each do |method|
      eval <<-DEF
        def self.#{method}(value = nil)
          value ? @#{method} = value : @#{method}
        end

        def #{method}
          @#{method} ||= self.class.send(:#{method})
        end
      DEF
    end

    def sandbox!
      return if host.include?('sandbox')
      host.sub!('ebay', 'sandbox.ebay')
    end

    def get(opts)
      response = connection.get(opts)
      Parser.new(response)
    end

    private

    def connection
      Excon.new("http://#{host}#{path}", headers: headers)
    end
  end
end
