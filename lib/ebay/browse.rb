# frozen_string_literal: true

require 'base64'

require 'ebay/config'
require 'ebay/requestable'

# Ruby wrapper to the eBay APIs
module Ebay
  # Returns a {Ebay::Browse#initialize Browse API} instance
  def self.browse(**params)
    Browse.new(**params)
  end

  # The Browse API allows your buyers to search eBay items by keyword and category. It also allows them to view and add
  # items to their eBay shopping cart.
  #
  # @see https://developer.ebay.com/api-docs/buy/browse/overview.html
  class Browse
    include Requestable

    self.endpoint = 'https://api.ebay.com/buy/browse/v1'

    # @return [String]
    attr_reader :access_token

    # @return [String]
    attr_reader :campaign_id

    # @return [String,nil]
    attr_reader :reference_id

    # @return [String,nil]
    attr_reader :country

    # @return [String,nil]
    attr_reader :zip

    # @return [String,nil]
    attr_reader :market_id

    # Returns a Browse API request instance
    #
    # @param [String] access_token
    # @param [String] campaign_id
    # @param [String] reference_id
    # @param [String] country
    # @param [String] zip
    # @param [String] market_id
    def initialize(access_token:, campaign_id:, reference_id: nil, country: nil, zip: nil, market_id: 'EBAY_US')
      @campaign_id = campaign_id
      @reference_id = reference_id
      @country = country
      @zip = zip
      @access_token = access_token
      @market_id = market_id
    end

    # Searches for eBay items by various query parameters and retrieves summaries of the item
    #
    # @param [Hash] params
    # @return [HTTP::Response]
    def search(params = {})
      url = build_url('item_summary', 'search')
      http.headers(build_headers).get(url, params: params)
    end

    # Searches for eBay items based on a image and retrieves their summaries
    #
    # @param [File] image
    # @param [Hash] params
    # @return [HTTP::Response]
    def search_by_image(image, params = {})
      url = build_url('item_summary', 'search_by_image')
      headers = build_headers.update('CONTENT-TYPE' => 'application/json')
      encoded_string = Base64.encode64(image.read)
      body = JSON.dump(image: encoded_string)

      http.headers(headers).post(url, params: params, body: body)
    end

    # Retrieves the details of a specific item
    #
    # @param [String] item_id
    # @param [Hash] params
    # @return [HTTP::Response]
    def get_item(item_id, params = {})
      url = build_url('item', item_id)
      params = params.merge(item_id: item_id)

      http.headers(build_headers).get(url, params: params)
    end

    # Retrieves the details of a specific item using its legacy item ID
    #
    # @param [String] legacy_item_id
    # @param [Hash] params
    # @return [HTTP::Response]
    def get_item_by_legacy_id(legacy_item_id, params = {})
      url = build_url('item', 'get_item_by_legacy_id')
      params = params.merge(legacy_item_id: legacy_item_id)

      http.headers(build_headers).get(url, params: params)
    end

    # Retrieves the details of the individual items in an item group
    #
    # @param [String] item_group_id
    # @return [HTTP::Response]
    def get_items_by_item_group(item_group_id)
      url = build_url('item', 'get_items_by_item_group')
      params = { item_group_id: item_group_id }

      http.headers(build_headers).get(url, params: params)
    end

    # Retrieves the details of the individual items in an item group
    #
    # @param [String] item_id
    # @param [String] marketplace_id
    # @return [HTTP::Response]
    def check_compatibility(item_id, marketplace_id, compatibility_properties)
      url = build_url('item', item_id, 'check_compatibility')
      headers = build_headers
      headers.update('X-EBAY-C-MARKETPLACE-ID' => marketplace_id, 'CONTENT-TYPE' => 'application/json')
      body = JSON.dump('compatibilityProperties' => compatibility_properties)

      http.headers(headers).post(url, body: body)
    end

    def add_item
      raise 'not implemented'
    end

    def get_shopping_cart
      raise 'not implemented'
    end

    def remove_item
      raise 'not implemented'
    end

    def update_quantity
      raise 'not implemented'
    end

    private

    def build_url(*resources, operation)
      [endpoint, *resources, operation].join('/')
    end

    def build_headers
      { 'AUTHORIZATION' => "Bearer #{access_token}",
        'X-EBAY-C-MARKETPLACE-ID' => market_id,
        'X-EBAY-C-ENDUSERCTX' => build_ebay_enduser_context }
    end

    def build_ebay_enduser_context
      { 'affiliateCampaignId' => campaign_id,
        'affiliateReferenceId' => reference_id,
        'contextualLocation' => build_contextual_location }.compact.map { |kv| kv.join('=') }.join(',')
    end

    def build_contextual_location
      string = { 'country' => country, 'zip' => zip }.compact.map { |kv| kv.join('=') }.join(',')
      CGI.escape(string) if string
    end
  end
end
