# frozen_string_literal: true

require 'helper'
require 'ebay/request'

module Ebay
  class TestRequest < Minitest::Test
    def setup
      @api = Class.new(Request)
    end

    def test_gateway_url
      @api.gateway_url = 'https://ebay.com'
      assert_equal 'https://ebay.com', @api.gateway_url
    end

    def test_url
      @api.gateway_url = 'https://ebay.com'
      request = @api.new
      assert_equal 'https://ebay.com', request.url
    end

    def test_sandbox_url
      @api.gateway_url = 'https://ebay.com'
      request = @api.new
      assert_equal 'https://sandbox.ebay.com', request.sandbox.url
    end

    def test_path
      @api.gateway_url = 'https://ebay.com'
      request = @api.new
      request.path = 'resource'
      assert_equal 'https://ebay.com/resource', request.url
    end

    def test_empty_params
      request = @api.new
      assert_kind_of Hash, request.params
    end
  end
end
