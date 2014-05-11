require 'excon'
require 'ebay/config'
require 'ebay/parser'

module Ebay
  class Request
    def sandbox!
      @host = @sandbox
    end

    def get(opts)
      Parser.new(connection.get(opts))
    end

    private

    def connection
      Excon.new("http://#{@host}#{@path}", @defaults)
    end
  end
end
