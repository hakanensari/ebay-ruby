# frozen_string_literal: true

require 'helper'
require 'ebay/product'

class TestProduct < Minitest::Test
  def setup
    VCR.insert_cassette('product')

    @product = Ebay::Product.new
    @product.sandbox!
  end

  def teardown
    VCR.eject_cassette
  end

  def test_gets_product_details
    params = {
      'GLOBAL-ID' => 'EBAY-US',
      'OPERATION-NAME' => 'getProductDetails',
      'productDetailsRequest.dataset' => 'DisplayableSearchResults',
      'productDetailsRequest.productIdentifier.ePID' => '83414'
    }
    parser = @product.get(query: params, expects: 200)
    assert_kind_of Hash, parser.parse
  end

  def test_gets_product_details_with_json
    params = {
      'RESPONSE-DATA-FORMAT' => 'JSON',
      'GLOBAL-ID' => 'EBAY-US',
      'OPERATION-NAME' => 'getProductDetails',
      'productDetailsRequest.dataset' => 'DisplayableSearchResults',
      'productDetailsRequest.productIdentifier.ePID' => '83414'
    }
    parser = @product.get(query: params, expects: 200)
    assert_kind_of Hash, parser.parse
  end
end
