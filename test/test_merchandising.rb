require 'helper'
require 'ebay/merchandising'

class TestMerchandising < Minitest::Test
  def setup
    VCR.insert_cassette('merchandising')

    @merchandising = Ebay::Merchandising.new
    @merchandising.sandbox!
  end

  def teardown
    VCR.eject_cassette
  end

  def test_gets_most_watched_items
    params = {
      'GLOBAL-ID' => 'EBAY-US',
      'OPERATION-NAME' => 'getMostWatchedItems'
    }
    parser = @merchandising.get(query: params, expects: 200)
    assert_kind_of Hash, parser.parse
  end

  def test_gets_most_watched_items_with_json
    params = {
      'RESPONSE-DATA-FORMAT' => 'JSON',
      'GLOBAL-ID' => 'EBAY-US',
      'OPERATION-NAME' => 'getMostWatchedItems'
    }
    parser = @merchandising.get(query: params, expects: 200)
    assert_kind_of Hash, parser.parse
  end
end
