# frozen_string_literal: true

require 'helper'
require 'ebay/requestable'

module Ebay
  class TestRequestable < Minitest::Test
    def setup
      klass = Class.new do
        include Requestable

        self.endpoint = 'https://api.ebay.com'
      end

      @request = klass.new
    end

    def test_endpoint
      assert @request.endpoint
    end

    def test_sandbox
      assert_includes @request.sandbox.endpoint, 'sandbox'
    end
  end
end
