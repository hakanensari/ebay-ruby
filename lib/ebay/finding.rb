# frozen_string_literal: true

require 'ebay/config'
require 'ebay/requestable'

module Ebay
  # The Finding API lets you search for and browse items listed on eBay and
  # provides useful metadata to refine searches.
  #
  # @see https://developer.ebay.com/Devzone/finding/Concepts/MakingACall.html
  # @see https://developer.ebay.com/Devzone/finding/CallRef/index.html
  class Finding
    include Requestable

    self.endpoint = 'https://svcs.ebay.com/services/search/FindingService/v1'

    # @return [String, nil]
    attr_reader :global_id

    # @return [String, nil]
    attr_reader :message_encoding

    # @return [String, nil]
    attr_reader :response_data_format

    # @return [String]
    attr_reader :security_appname

    # @return [String, nil]
    attr_reader :service_version

    # Returns a Finding API request instance
    #
    # @see https://developer.ebay.com/Devzone/finding/Concepts/SiteIDToGlobalID.html
    # @param [String] global_id
    # @param [String] message_encoding
    # @param [String] response_data_format
    # @param [String] security_appname
    # @param [String] service_version
    def initialize(global_id: nil, message_encoding: nil,
                   response_data_format: 'JSON',
                   security_appname: Config.app_id, service_version: nil)
      @global_id = global_id
      @message_encoding = message_encoding
      @response_data_format = response_data_format
      @security_appname = security_appname
      @service_version = service_version
    end

    # Searches for items whose listings are completed
    #
    # @param [Hash] payload
    # @return [HTTP::Response]
    def find_completed_items(payload = {})
      request('findCompletedItems', payload)
    end

    # Searches for items by category or keyword or both
    #
    # @param [Hash] payload
    # @return [HTTP::Response]
    def find_items_advanced(payload = {})
      request('findItemsAdvanced', payload)
    end

    # Searches for items using specific eBay category ID numbers
    #
    # @param [Hash] payload
    # @return [HTTP::Response]
    def find_items_by_category(payload = {})
      request('findItemsByCategory', payload)
    end

    # Searches for items by a keyword query
    #
    # @param [String] keywords
    # @param [Hash] payload
    # @return [HTTP::Response]
    def find_items_by_keywords(keywords, payload = {})
      payload.update('keywords' => keywords)
      request('findItemsByKeywords', payload)
    end

    # Searches for items using specific eBay product values\
    #
    # @param [String] product_id
    # @param [String] product_id_type
    # @param [Hash] payload
    # @return [HTTP::Response]
    def find_items_by_product(product_id, product_id_type, payload = {})
      payload.update('productId' => product_id,
                     'productId.@type' => product_id_type)

      request('findItemsByProduct', payload)
    end

    # Searches for items in the eBay store inventories
    #
    # @param [Hash] payload
    # @return [HTTP::Response]
    def find_items_in_ebay_stores(payload = {})
      request('findItemsIneBayStores', payload)
    end

    # Retrieves category and/or aspect histogram information for an eBay
    # category
    #
    # @param [String] category_id
    # @return [HTTP::Response]
    def get_histograms(category_id)
      request('getHistograms', 'categoryId' => category_id)
    end

    # Retrieves commonly used words found in eBay titles, based on the words you
    # supply
    #
    # @param [String] keywords
    # @return [HTTP::Response]
    def get_search_keywords_recommendation(keywords)
      request('getSearchKeywordsRecommendation', 'keywords' => keywords)
    end

    # Returns the current version of the service
    #
    # @return [HTTP::Response]
    def get_version
      request('getVersion')
    end

    private

    def request(operation, payload = {})
      params = { 'GLOBAL-ID' => global_id,
                 'MESSAGE-ENCODING' => message_encoding,
                 'OPERATION-NAME' => operation,
                 'REQUEST-DATA-FORMAT' => 'JSON',
                 'RESPONSE-DATA-FORMAT' => response_data_format,
                 'SECURITY-APPNAME' => security_appname,
                 'SERVICE-VERSION' => service_version }.compact

      http.post(endpoint, params: params, body: JSON.dump(payload))
    end
  end
end
