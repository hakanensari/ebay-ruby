require 'helper'
require 'ebay/shopping'

class TestShopping < Minitest::Test
  def setup
    VCR.insert_cassette('shopping')

    @shopping = Ebay::Shopping.new
    @shopping.sandbox!
  end

  def teardown
    VCR.eject_cassette
  end

  def test_finds_half_products
    params = {
      'CALLNAME' => 'FindHalfProducts',
      'QueryKeywords' => 'ernesto laclau'
    }
    parser = @shopping.get(query: params, expects: 200)
    assert_kind_of Hash, parser.parse
  end

  def test_finds_half_products_with_json
    params = {
      'CALLNAME' => 'FindHalfProducts',
      'RESPONSEENCODING' => 'JSON',
      'QueryKeywords' => 'ernesto laclau'
    }
    parser = @shopping.get(query: params, expects: 200)
    assert_kind_of Hash, parser.parse
  end
end
