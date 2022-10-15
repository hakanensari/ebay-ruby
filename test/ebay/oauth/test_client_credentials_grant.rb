# frozen_string_literal: true

require 'helper'
require 'ebay/oauth/client_credentials_grant'

module Ebay
  module Oauth
    class TestClientCredentialsGrant < Minitest::Test
      def setup
        VCR.insert_cassette('client_credentials_grant')
        @grant = ClientCredentialsGrant.new.sandbox
      end

      def teardown
        VCR.eject_cassette
      end

      def test_request
        response = @grant.request
        assert_predicate response.status, :ok?
      end

      def test_mint_access_token
        assert @grant.mint_access_token
      end
    end

    class TestBadCredentials < Minitest::Test
      def setup
        VCR.insert_cassette('bad_credentials')
        @grant = ClientCredentialsGrant.new.sandbox
      end

      def teardown
        VCR.eject_cassette
      end

      def test_request
        response = @grant.request
        assert_predicate response.status, :unauthorized?
      end

      def test_mint_access_token
        assert_raises Ebay::Oauth::Error do
          @grant.mint_access_token
        end
      end
    end
  end
end
