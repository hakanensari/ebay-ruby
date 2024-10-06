# frozen_string_literal: true

require "helper"
require "ebay/requestable"

module Ebay
  class TestRequestable < Minitest::Test
    def setup
      VCR.insert_cassette("requestable")

      klass = Class.new do
        include Requestable
        self.endpoint = "https://api.ebay.com"
      end
      @request = klass.new
    end

    def teardown
      VCR.eject_cassette
    end

    def test_endpoint
      assert(@request.endpoint)
    end

    def test_sandbox
      assert_includes(@request.sandbox.endpoint, "sandbox")
    end

    def test_persistence
      @request.persistent

      assert_predicate(@request.http, :persistent?)
    end

    def test_logging
      require "logger"
      logdev = StringIO.new
      logger = Logger.new(logdev)
      @request.use(logging: { logger: logger })
      @request.http.get("https://www.google.com")

      refute_empty(logdev.string)
    end
  end
end
