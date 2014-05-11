require 'helper'
require 'ebay/parser'

class TestEbayParser < Minitest::Test
  def build_response(content_type, body)
    OpenStruct.new(
      headers: { 'Content-Type' => content_type },
      body: body
    )
  end

  def test_parses_xml
    response = build_response('text/xml', '<foo>bar</foo>')
    parser = Ebay::Parser.new(response)

    assert_kind_of Hash, parser.parse
  end

  def test_parses_json
    response = build_response('application/json', '{"foo":"bar"}')
    parser = Ebay::Parser.new(response)

    assert_kind_of Hash, parser.parse
  end
end
