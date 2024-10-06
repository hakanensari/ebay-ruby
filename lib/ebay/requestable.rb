# frozen_string_literal: true

require "http"

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

    # @!attribute [r] headers
    # @return [Hash]
    attr_accessor :headers

    # Sets the eBay Market
    #
    # @param [String]
    def market_id=(market_id)
      @headers ||= {}
      @headers["X-EBAY-SOA-GLOBAL-ID"] = market_id
    end

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
      @endpoint = endpoint.sub("ebay", "sandbox.ebay")
      self
    end

    # Flags request as persistent
    #
    # @param [Integer] timeout
    # @return [self]
    def persistent(timeout: 5)
      self.http = http.persistent(endpoint, timeout: timeout)
      self
    end

    # @!method use(*features)
    #   Turns on {https://github.com/httprb/http HTTP} features
    #
    #   @param features
    #   @return [self]
    #
    # @!method via(*proxy)
    #   Makes a request through an HTTP proxy
    #
    #   @param [Array] proxy
    #   @raise [HTTP::Request::Error] if HTTP proxy is invalid
    #   @return [self]
    [:timeout, :via, :through, :use].each do |method_name|
      define_method(method_name) do |*args, &block|
        self.http = http.send(method_name, *args, &block)
        self
      end
    end
  end
end
