# frozen_string_literal: true

require 'ebay/config'
require 'ebay/requestable'

module Ebay
  # Retrieves information about products or item listings on eBay to help you
  # sell more merchandise to eBay buyers
  #
  # @see https://developer.ebay.com/Devzone/merchandising/docs/Concepts/MerchandisingAPI_FormatOverview.html
  # @see https://developer.ebay.com/Devzone/merchandising/docs/CallRef/index.html
  class Merchandising
    include Requestable

    self.endpoint = 'https://svcs.ebay.com/MerchandisingService'

    # @return [String]
    attr_reader :consumer_id

    # @return [String]
    attr_reader :global_id

    # @return [String]
    attr_reader :response_data_format

    # @return [String]
    attr_reader :service_version

    # Returns a Finding API request instance
    #
    # @param [String] consumer_id
    # @param [String] global_id
    # @param [String] response_data_format
    # @param [String] service_version
    def initialize(consumer_id: Config.app_id, global_id: nil,
                   response_data_format: nil, service_version: nil)
      @consumer_id = consumer_id
      @global_id = global_id
      @response_data_format = response_data_format
      @service_version = service_version
    end

    # Retrieves data for items with the highest watch count
    #
    # @param [Hash] payload
    # @return [HTTP::Response]
    def get_most_watched_items(payload = {})
      request('getMostWatchedItems', payload)
    end

    # Retrieves recommended items from categories related to a specified
    # category or item
    #
    # @param [Hash] payload
    # @return [HTTP::Response]
    def get_related_category_items(payload = {})
      request('getRelatedCategoryItems', payload)
    end

    # Retrieves items that are similar to the specified item
    #
    # @param [String] item_id
    # @param [Hash] payload
    # @return [HTTP::Response]
    def get_similar_items(item_id, payload = {})
      payload = payload.merge('itemId' => item_id)
      request('getSimilarItems', payload)
    end

    # Returns the current service version
    #
    # @return [HTTP::Response]
    def get_version
      request('getVersion')
    end

    private

    def request(operation, payload = {})
      params = { 'CONSUMER-ID' => consumer_id,
                 'GLOBAL-ID' => global_id,
                 'OPERATION-NAME' => operation,
                 'REQUEST-DATA-FORMAT' => 'JSON',
                 'RESPONSE-DATA-FORMAT' => response_data_format,
                 'SERVICE-VERSION' => service_version }.compact

      http.post(endpoint, params: params, body: JSON.dump(payload))
    end
  end
end
