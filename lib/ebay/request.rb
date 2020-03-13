# frozen_string_literal: true

require 'http'

require 'ebay/config'

module Ebay
  # @abstract Subclass this class to implement an API
  class Request
    class << self
      # @return [String]
      attr_accessor :gateway_url
    end

    # @return [String, nil]
    attr_accessor :path

    # @!attribute [r] url
    # @return [String]
    def url
      [gateway_url, path].compact.join('/')
    end

    # @return [Hash]
    attr_accessor :headers

    # @!attribute [r] params
    # @return [Hash]
    def params
      @params ||= {}
    end

    # @return [Hash]
    attr_writer :params

    # Runs the request in the eBay Sandbox environment
    #
    # @return [self]
    def sandbox
      @gateway_url = gateway_url.sub('ebay', 'sandbox.ebay')
      self
    end

    protected

    def get
      HTTP.headers(headers)
          .get(url, params: params)
    end

    private

    def gateway_url
      @gateway_url ||= self.class.gateway_url
    end
  end
end
