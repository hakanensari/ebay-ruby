# frozen_string_literal: true

# Ruby wrapper to the eBay APIs
module Ebay
  class << self
    # Configures credentials for accessing the eBay APIs
    # @yield {Config}
    def configure
      yield Config
    end
  end

  # Configures credentials for accessing the eBay APIs
  module Config
    class << self
      # @!attribute [rw] app_id
      # @return [String] unique identifier for the application
      # @note This attribute defaults to the `EBAY_APP_ID` environment variable.
      def app_id
        @app_id ||= ENV.fetch("EBAY_APP_ID", nil)
      end

      # @!attribute [rw] dev_id
      # @return [String] unique identifier for the developer's account
      # @note This attribute defaults to the `EBAY_DEV_ID` environment variable.
      def dev_id
        @dev_id ||= ENV.fetch("EBAY_DEV_ID", nil)
      end

      # @!attribute [rw] cert_id
      # @return [String] certificate that authenticates the application when
      #   making API calls
      # @note This attribute defaults to the `EBAY_CERT_ID` environment
      #   variable.
      def cert_id
        @cert_id ||= ENV.fetch("EBAY_CERT_ID", nil)
      end

      attr_writer :app_id, :dev_id, :cert_id
    end
  end
end
