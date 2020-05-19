# frozen_string_literal: true

require 'helper'
require 'ebay/shopping'

module Ebay
  class TestShopping < Minitest::Test
    def setup
      VCR.insert_cassette('shopping')
      @request = Ebay.shopping(response_encoding: 'JSON').sandbox
    end

    def teardown
      VCR.eject_cassette
    end

    def test_find_products
      response = @request.find_products('QueryKeywords' => 'tolkien')
      assert_success response
    end

    def test_get_category_info
      response = @request.get_category_info('267')
      assert_success response
    end

    def test_get_ebay_time
      response = @request.get_ebay_time
      assert_success response
    end

    def test_get_item_status
      response = @request.get_item_status('291914595965')
      assert_success response
    end

    def test_get_multiple_items
      response = @request.get_multiple_items('291914595965', '141963466041')
      assert_success response
    end

    def test_get_shipping_costs
      response = @request.get_shipping_costs('333112555211',
                                             'DestinationCountryCode' => 'GB')
      assert_success response
    end

    def test_get_single_item
      response = @request.get_single_item('333112555211')
      assert_success response
    end

    def test_get_user_profile
      response = @request.get_user_profile('shopspell')
      assert_success response
    end

    private

    def assert_success(response)
      assert response.status.ok?
      assert_equal 'Success', JSON.parse(response.body)['Ack']
    end
  end
end
