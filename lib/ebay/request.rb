# frozen_string_literal: true

require 'excon'
require 'ebay/config'
require 'ebay/parser'

module Ebay
  class Request
    %i[host path headers].each do |method|
      eval <<-DEF, binding, __FILE__, __LINE__ + 1
        def self.#{method}(&block)
          block ? @#{method} = block : @#{method}.call
        end

        def #{method}
          @#{method} ||= self.class.send(:#{method})
        end
      DEF
    end

    def sandbox!
      return if host.include?('sandbox')

      @host = host.sub('ebay', 'sandbox.ebay')
    end

    def get(opts)
      response = connection.get(opts)
      Parser.new(response)
    end

    private

    def connection
      Excon.new("https://#{host}#{path}", headers: headers)
    end
  end
end
