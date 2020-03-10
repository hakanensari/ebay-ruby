# frozen_string_literal: true

require 'helper'
require 'ebay/product_metadata'

class TestProductMetadata < Minitest::Test
  def setup
    VCR.insert_cassette('product_metadata')

    @product_metadata = Ebay::ProductMetadata.new
    @product_metadata.sandbox!
  end

  def teardown
    VCR.eject_cassette
  end

  def test_gets_product_search_data_version
    params = {
      'GLOBAL-ID' => 'EBAY-US',
      'OPERATION-NAME' => 'getProductSearchDataVersion',
      'categoryId' => '123'
    }
    parser = @product_metadata.get(query: params, expects: 200)
    assert_kind_of Hash, parser.parse
  end

  def test_gets_product_search_data_version_with_json
    params = {
      'RESPONSE-DATA-FORMAT' => 'JSON',
      'GLOBAL-ID' => 'EBAY-US',
      'OPERATION-NAME' => 'getProductSearchDataVersion',
      'categoryId' => '123'
    }
    parser = @product_metadata.get(query: params, expects: 200)
    assert_kind_of Hash, parser.parse
  end
end
