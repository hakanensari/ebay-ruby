# frozen_string_literal: true

require "helper"
require "ebay/merchandising"

module Ebay
  class TestMerchandising < Minitest::Test
    def setup
      VCR.insert_cassette("merchandising")
      @request = Ebay.merchandising(response_data_format: "JSON").sandbox
    end

    def teardown
      VCR.eject_cassette
    end

    def test_get_most_watched_items
      response = @request.get_most_watched_items("categoryId" => "267")

      assert_predicate(response.status, :ok?)
    end

    def test_get_related_category_items
      response = @request.get_related_category_items("categoryId" => "267")

      assert_predicate(response.status, :ok?)
    end

    def test_get_similar_items
      response = @request.get_similar_items("333112555211")

      assert_predicate(response.status, :ok?)
    end

    def test_get_version
      response = @request.get_version

      assert_predicate(response.status, :ok?)
    end
  end
end
