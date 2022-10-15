# frozen_string_literal: true

require 'ebay/config'
require 'ebay/requestable'

module Ebay
  module Oauth
    class Error < StandardError; end

    # Mints an access token to use in API requests
    #
    # @see https://developer.ebay.com/api-docs/static/oauth-client-credentials-grant.html
    class ClientCredentialsGrant
      include Requestable

      self.endpoint = 'https://api.ebay.com/identity/v1/oauth2/token'

      # @return [String]
      attr_reader :app_id

      # @return [String]
      attr_reader :cert_id

      # @param [String] app_id
      # @param [String] cert_id
      def initialize(app_id: Config.app_id, cert_id: Config.cert_id)
        @app_id = app_id
        @cert_id = cert_id
      end

      # Mints a new access token
      #
      # @raise [Ebay::Oauth::Error] if the request fails
      # @return [String]
      def mint_access_token
        response = request
        raise Error, response.status.reason unless response.status.ok?

        JSON.parse(response).fetch('access_token')
      end

      # Requests a client credentials grant
      #
      # @return [HTTP::Response]
      def request
        http.basic_auth(user: app_id, pass: cert_id)
            .post(endpoint, form: payload)
      end

      private

      def payload
        { grant_type: 'client_credentials',
          scope: 'https://api.ebay.com/oauth/api_scope' }
      end
    end
  end
end
