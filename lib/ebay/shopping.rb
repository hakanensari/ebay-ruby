# frozen_string_literal: true

require 'ebay/request'

module Ebay
  # The eBay Shopping API makes it easy to search for things on eBay.
  #
  # @see https://developer.ebay.com/Devzone/shopping/docs/CallRef/index.html
  class Shopping < Request
    self.gateway_url = 'https://open.api.ebay.com/shopping'

    # @return [#to_s] the application ID
    attr_reader :app_id

    # @return [#to_s] the application ID
    attr_reader :site_id

    # @return [#to_s] the API version that your application supports
    attr_reader :version

    # @return [#to_s] an ID to identify you to your tracking partner
    attr_reader :tracking_id

    # @return [#to_s] the third party who is your tracking partner
    attr_reader :tracking_partner_code

    # @return [#to_s] a custom ID you can leverage to better monitor your
    #   marketing efforts
    attr_reader :affiliate_user_id

    # Returns a Finding API request instance
    #
    # @param [#to_s] app_id
    # @param [#to_s] site_id
    # @param [#to_s] tracking_id
    # @param [#to_s] tracking_partner_code
    # @param [#to_s] affiliate_user_id
    def initialize(app_id: Config.app_id, site_id: nil, version: '1119',
                   tracking_id: nil, tracking_partner_code: nil,
                   affiliate_user_id: nil)
      @app_id = app_id
      @site_id = site_id
      @version = version
      @tracking_id = tracking_id
      @tracking_partner_code = tracking_partner_code
      @affiliate_user_id = affiliate_user_id
    end

    # Returns one or more eBay catalog products based on a query string or
    # product ID value
    #
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def find_products(**arguments)
      params.update(arguments)
      build('FindProducts').get
    end

    # Retrieves high-level data for a specified eBay category
    #
    # @param [String] category_id
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def get_category_info(category_id, **arguments)
      params.update('CategoryID' => category_id)
            .update(arguments)

      build('GetCategoryInfo').get
    end

    # Gets the official eBay system time in GMT
    #
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def get_ebay_time(**arguments)
      params.update(arguments)
      build('GeteBayTime').get
    end

    # Retrieves the current status of up to 20 eBay listings
    #
    # @param [String] item_ids
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def get_item_status(*item_ids, **arguments)
      params.update('ItemID' => item_ids.join(','))
            .update(arguments)

      build('GetItemStatus').get
    end

    # Retrieves publicly available data for one or more listings
    #
    # @param [String] item_ids
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def get_multiple_items(*item_ids, **arguments)
      params.update('ItemID' => item_ids.join(','))
            .update(arguments)

      build('GetMultipleItems').get
    end

    # Gets shipping costs for a listing
    #
    # @param [String] item_id
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def get_shipping_costs(item_id, **arguments)
      params.update('ItemID' => item_id)
            .update(arguments)

      build('GetShippingCosts').get
    end

    # Gets publicly visible details about one listing
    #
    # @param [String] item_id
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def get_single_item(item_id, **arguments)
      params.update('ItemID' => item_id)
            .update(arguments)

      build('GetSingleItem').get
    end

    # Retrieves user information
    #
    # @param [String] user_id
    # @param [Hash] arguments
    # @return [HTTP::Response]
    def get_user_profile(user_id, **arguments)
      params.update('UserID' => user_id)
            .update(arguments)

      build('GetUserProfile').get
    end

    private

    def build(verb)
      self.params = default_params.update('callname' => verb)
                                  .update(params)

      self
    end

    def default_params
      { 'affiliateuserid' => affiliate_user_id,
        'appid' => app_id,
        'responseencoding' => 'JSON',
        'siteid' => site_id,
        'trackingid' => tracking_id,
        'trackingpartnercode' => tracking_partner_code,
        'version' => version }.compact
    end
  end
end
