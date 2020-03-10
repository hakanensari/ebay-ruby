# frozen_string_literal: true

require 'excon'
require 'ebay/config'
require 'ebay/parser'

module Ebay
  class Request
    %i(host path headers).each do |method|
        def self.#{method}(value = nil)
          value ? @#{method} = value : @#{method}
      eval <<-DEF, binding, __FILE__, __LINE__ + 1
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
      Excon.new("https://#{host}#{path}", headers: headers)
    end
  end
end
