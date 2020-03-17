# frozen_string_literal: true

require 'helper'
require 'ebay/finding'

module Ebay
  class TestFinding < Minitest::Test
    def setup
      VCR.insert_cassette('finding')
      @request = Ebay::Finding.new.sandbox
    end

    def teardown
      VCR.eject_cassette
    end

    def test_find_completed_items
      response = @request.find_completed_items('keywords' => 'iphone')
      assert response.status.ok?
    end

    def test_find_items_advanced
      response = @request.find_items_advanced('keywords' => 'iphone')
      assert response.status.ok?
    end

    def test_find_items_by_category
      response = @request.find_items_by_category('categoryId' => '10181')
      assert response.status.ok?
    end

    def test_find_items_by_keywords
      response = @request.find_items_by_keywords('iphone')
      assert response.status.ok?
    end

    def test_find_items_by_product
      response = @request.find_items_by_product('53039031', 'ReferenceID')
      assert response.status.ok?
    end

    def test_find_items_in_ebay_stores
      response = @request.find_items_in_ebay_stores('storeName' =>
        "Laura_Chen's_Small_Store")
      assert response.status.ok?
    end

    def test_get_histograms
      response = @request.get_histograms('11233')
      assert response.status.ok?
    end

    def test_get_search_keywords_recommendation
      response = @request.get_search_keywords_recommendation('acordian')
      assert response.status.ok?
    end

    def test_get_version
      response = @request.get_version
      assert response.status.ok?
    end

    def test_params_with_dots
      params = { 'paginationInput.entriesPerPage' => '1' }
      response = @request.find_items_by_keywords('iphone', params)
      data = JSON.parse(response)
      count = data['findItemsByKeywordsResponse'].first['searchResult']
                                                 .first['@count'].to_i
      assert_equal 1, count
    end
  end
end
