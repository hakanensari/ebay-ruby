# frozen_string_literal: true

require 'ebay/config'
require 'ebay/requestable'

# Ruby wrapper to the eBay APIs
module Ebay
  # Returns a {Ebay::Shopping#initialize Shopping API} instance
  def self.shopping(**params)
    Shopping.new(**params)
  end

  # The eBay Shopping API makes it easy to search for things on eBay.
  #
  # @see https://developer.ebay.com/Devzone/shopping/docs/Concepts/ShoppingAPI_FormatOverview.html
  # @see https://developer.ebay.com/Devzone/shopping/docs/CallRef/index.html
  class Shopping
    include Requestable

    self.endpoint = 'https://open.api.ebay.com/shopping'

    # @return [String]
    attr_reader :app_id

    # @return [String]
    attr_reader :response_encoding

    # @return [String]
    attr_reader :site_id

    # @return [String]
    attr_reader :version

    # @return [String]
    attr_reader :version_handling

    # @return [String]
    attr_reader :tracking_id

    # @return [String]
    attr_reader :tracking_partner_code

    # @return [String]
    attr_reader :affiliate_user_id

    # Returns a Finding API request instance
    #
    # @param [String] app_id
    # @param [String] response_encoding
    # @param [String] site_id
    # @param [String] version
    # @param [String] version_handling
    # @param [String] tracking_id
    # @param [String] tracking_partner_code
    # @param [String] affiliate_user_id
    def initialize(app_id: Config.app_id, response_encoding: nil,
                   site_id: nil, version: '1119',
                   version_handling: nil, tracking_id: nil,
                   tracking_partner_code: nil, affiliate_user_id: nil)
      @app_id = app_id
      @response_encoding = response_encoding
      @site_id = site_id
      @version = version
      @version_handling = version_handling
      @tracking_id = tracking_id
      @tracking_partner_code = tracking_partner_code
      @affiliate_user_id = affiliate_user_id
    end

    # Returns one or more eBay catalog products based on a query string or
    # product ID value
    #
    # @param [Hash] payload
    # @return [HTTP::Response]
    def find_products(payload = {})
      request('FindProducts', payload)
    end

    # Retrieves high-level data for a specified eBay category
    #
    # @param [String] category_id
    # @param [Hash] payload
    # @return [HTTP::Response]
    def get_category_info(category_id, payload = {})
      payload = payload.merge('CategoryID' => category_id)
      request('GetCategoryInfo', payload)
    end

    # Gets the official eBay system time in GMT
    #
    # @param [Hash] payload
    # @return [HTTP::Response]
    def get_ebay_time(payload = {})
      request('GeteBayTime', payload)
    end

    # Retrieves the current status of up to 20 eBay listings
    #
    # @overload get_item_status(*item_ids, payload = {})
    #   @param [String] item_ids
    #   @param [Hash] payload
    #   @return [HTTP::Response]
    def get_item_status(*item_ids)
      payload = item_ids.last.is_a?(Hash) ? item_ids.pop : {}
      payload = payload.merge('ItemID' => item_ids.map(&:to_s))
      request('GetItemStatus', payload)
    end

    # Retrieves publicly available data for one or more listings
    #
    # @overload get_multiple_items(*item_ids, payload = {})
    #   @param [String] item_ids
    #   @param [Hash] payload
    #   @return [HTTP::Response]
    def get_multiple_items(*item_ids)
      payload = item_ids.last.is_a?(Hash) ? item_ids.pop : {}
      payload = payload.merge('ItemID' => item_ids.map(&:to_s))

      request('GetMultipleItems', payload)
    end

    # Gets shipping costs for a listing
    #
    # @param [String] item_id
    # @param [Hash] payload
    # @return [HTTP::Response]
    def get_shipping_costs(item_id, payload = {})
      payload = payload.merge('ItemID' => item_id)
      request('GetShippingCosts', payload)
    end

    # Gets publicly visible details about one listing
    #
    # @param [String] item_id
    # @param [Hash] payload
    # @return [HTTP::Response]
    def get_single_item(item_id, payload = {})
      payload = payload.merge('ItemID' => item_id)
      request('GetSingleItem', payload)
    end

    # Retrieves user information
    #
    # @param [String] user_id
    # @param [Hash] payload
    # @return [HTTP::Response]
    def get_user_profile(user_id, payload = {})
      payload = payload.merge('UserID' => user_id)
      request('GetUserProfile', payload)
    end

    private

    def request(operation, payload = {})
      params = { 'appid' => app_id,
                 'callname' => operation,
                 'requestencoding' => 'JSON',
                 'responseencoding' => response_encoding,
                 'siteid' => site_id,
                 'version' => version,
                 'versionhandling' => version_handling,
                 'affiliateuserid' => affiliate_user_id,
                 'trackingid' => tracking_id,
                 'trackingpartnercode' => tracking_partner_code }.compact

      http.post(endpoint, params: params, body: JSON.dump(payload))
    end
  end
end
