# frozen_string_literal: true

require 'helper'
require 'ebay/browse'
require 'ebay/oauth/client_credentials_grant'

module Ebay
  class TestBrowse < Minitest::Test
    def setup
      VCR.insert_cassette('browse')

      # Some calls work only in the production environment, so I'm not running
      # the tests in the sandbox environment
      access_token = Oauth::ClientCredentialsGrant.new.mint_access_token
      @request = Ebay.browse(campaign_id: '123', country: 'US', zip: '19406',
                             access_token: access_token)
    end

    def teardown
      VCR.eject_cassette
    end

    def test_search
      response = @request.search(q: 'iphone')
      data = JSON.parse(response)
      assert data.key?('itemSummaries')
    end

    def test_search_by_image
      image = File.open('./test/data/product.jpg')
      response = @request.search_by_image(image)
      data = JSON.parse(response)
      assert data.key?('itemSummaries')
    end

    def test_get_item
      response = @request.get_item('v1|312593647853|0')
      data = JSON.parse(response)
      assert data.key?('itemId')
    end

    def test_get_item_by_legacy_id
      response = @request.get_item_by_legacy_id('312593647853')
      data = JSON.parse(response)
      assert data.key?('itemId')
    end

    def test_get_items_by_item_group
      response = @request.get_items_by_item_group('233444680161')
      data = JSON.parse(response)
      assert data.key?('items')
    end
  end
end
