# frozen_string_literal: true

require 'ebay/request'

module Ebay
  # The Finding API lets you search for and browse items listed on eBay and
  # provides useful metadata to refine searches.
  #
  # @see https://developer.ebay.com/Devzone/finding/CallRef/index.html
  class Finding < Request
    self.gateway_url = 'https://svcs.ebay.com/services/search/FindingService/v1'

    # @return [#to_s] the application ID
    attr_reader :app_id

    # @return [#to_s] a unique identifier that identifies an eBay site
    attr_reader :global_id

    # Returns a Finding API request instance
    #
    # @see https://developer.ebay.com/Devzone/finding/Concepts/SiteIDToGlobalID.html
    # @param [#to_s] app_id
    # @param [#to_s] global_id
    def initialize(app_id: Config.app_id, global_id: nil)
      @app_id = app_id
      @global_id = global_id
    end

    # Searches for items whose listings are completed
    #
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def find_completed_items(**arguments)
      params.update(arguments)
      build('findCompletedItems').get
    end

    # Searches for items by category or keyword or both
    #
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def find_items_advanced(**arguments)
      params.update(arguments)
      build('findItemsAdvanced').get
    end

    # Searches for items using specific eBay category ID numbers
    #
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def find_items_by_category(**arguments)
      params.update(arguments)
      build('findItemsByCategory').get
    end

    # Searches for items by a keyword query
    #
    # @param [String] keywords
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def find_items_by_keywords(keywords, **arguments)
      params.update(arguments)
            .update('keywords' => keywords)

      build('findItemsByKeywords').get
    end

    # Searches for items using specific eBay product values\
    #
    # @param [String] product_id
    # @param [String] product_id_type
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def find_items_by_product(product_id, product_id_type, **arguments)
      params.update(arguments)
            .update('productId' => product_id,
                    'productId.@type' => product_id_type)

      build('findItemsByProduct').get
    end

    # Searches for items in the eBay store inventories
    #
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def find_items_in_ebay_stores(**arguments)
      params.update(arguments)
      build('findItemsIneBayStores').get
    end

    # Retrieves category and/or aspect histogram information for an eBay
    # category
    #
    # @param [String] category_id
    # @return [HTTP::Response]
    def get_histograms(category_id)
      params.update('categoryId' => category_id)
      build('getHistograms').get
    end

    # Retrieves commonly used words found in eBay titles, based on the words you
    # supply
    #
    # @param [String] keywords
    # @return [HTTP::Response]
    def get_search_keywords_recommendation(keywords)
      params.update('keywords' => keywords)
      build('getSearchKeywordsRecommendation').get
    end

    # Returns the current version of the service
    #
    # @return [HTTP::Response]
    def get_version
      build('getVersion').get
    end

    private

    def build(verb)
      self.params = default_params.update('OPERATION-NAME' => verb)
                                  .update(params)

      self
    end

    def default_params
      { 'GLOBAL-ID' => global_id,
        'RESPONSE-DATA-FORMAT' => 'JSON',
        'SECURITY-APPNAME' => app_id }.compact
    end
  end
end
