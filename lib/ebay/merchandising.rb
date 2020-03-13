# frozen_string_literal: true

require 'ebay/request'

module Ebay
  # Retrieves information about products or item listings on eBay to help you
  # sell more merchandise to eBay buyers
  class Merchandising < Request
    self.gateway_url = 'https://svcs.ebay.com/MerchandisingService'

    # @return [#to_s] the application ID
    attr_reader :app_id

    # @return [#to_s] a unique identifier that identifies an eBay site
    attr_reader :global_id

    # Returns a Finding API request instance
    #
    # @param [#to_s] app_id
    # @param [#to_s] global_id
    def initialize(app_id: Config.app_id, global_id: nil)
      @app_id = app_id
      @global_id = global_id
    end

    # Retrieves data for items with the highest watch count
    #
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def get_most_watched_items(**arguments)
      params.update(arguments)
      operation('getMostWatchedItems').get
    end

    # Retrieves recommended items from categories related to a specified
    # category or item
    #
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def get_related_category_items(**arguments)
      params.update(arguments)
      operation('getRelatedCategoryItems').get
    end

    # Retrieves items that are similar to the specified item
    #
    # @param [String] item_id
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def get_similar_items(item_id, **arguments)
      params.update('itemId' => item_id)
            .update(arguments)

      operation('getSimilarItems').get
    end

    # Returns the current service version
    #
    # @return [HTTP::Response]
    def get_version
      operation('getVersion').get
    end

    private

    def operation(verb)
      self.params = default_params.update('OPERATION-NAME' => verb,
                                          'RESPONSE-PAYLOAD' => nil)
                                  .update(params)

      self
    end

    def default_params
      { 'CONSUMER-ID' => app_id,
        'GLOBAL-ID' => global_id,
        'RESPONSE-DATA-FORMAT' => 'JSON' }
    end
  end
end
