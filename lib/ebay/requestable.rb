# frozen_string_literal: true

require 'http'

module Ebay
  # Adds an HTTP client and ability to switch to the eBay Sandbox environment
  module Requestable
    class << self
      private

      def included(base)
        class << base
          attr_accessor :endpoint
        end
      end
    end

    # @return [HTTP::Client]
    attr_writer :http

    # @!attribute [r] http
    # @return [HTTP::Client]
    def http
      @http ||= HTTP::Client.new
    end

    # @!attribute [r] endpoint
    # @return [String]
    def endpoint
      @endpoint ||= self.class.endpoint
    end

    # Switches to the eBay Sandbox environment
    #
    # @return [self]
    def sandbox
      @endpoint = endpoint.sub('ebay', 'sandbox.ebay')
      self
    end
  end
end
