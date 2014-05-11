require 'helper'
require 'ebay/finding'

class TestFinding < Minitest::Test
  def setup
    VCR.insert_cassette('finding')

    @finding = Ebay::Finding.new
    @finding.sandbox!
  end

  def teardown
    VCR.eject_cassette
  end

  def test_finds_items_by_keywords
    params = {
      'GLOBAL-ID' => 'EBAY-US',
      'OPERATION-NAME' => 'findItemsByKeywords',
      'keywords' => 'ernesto laclau'
    }
    parser = @finding.get(query: params, expects: 200)
    assert_kind_of Hash, parser.parse
  end

  def test_finds_items_by_keywords_with_json
    params = {
      'RESPONSEENCODING' => 'JSON',
      'GLOBAL-ID' => 'EBAY-US',
      'OPERATION-NAME' => 'findItemsByKeywords',
      'keywords' => 'ernesto laclau'
    }
    parser = @finding.get(query: params, expects: 200)
    assert_kind_of Hash, parser.parse
  end
end
