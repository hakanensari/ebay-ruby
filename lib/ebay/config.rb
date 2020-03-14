# frozen_string_literal: true

# Ruby wrapper to the eBay APIs
module Ebay
  # Configures credentials for accessing the eBay APIs
  # @yield {Config}
  def self.configure
    yield Config
  end

  # Stores credentials for accessing the eBay APIs
  module Config
    class << self
      # @!attribute [rw] app_id
      # @return [String] unique identifier for the application
      # @note This attribute defaults to the `EBAY_APP_ID` environment variable.

      # @!attribute [rw] dev_id
      # @return [String] unique identifier for the developer's account
      # @note This attribute defaults to the `EBAY_DEV_ID` environment variable.

      # @!attribute [rw] cert_id
      # @return [String] certificate that authenticates the application when
      #   making API calls
      # @note This attribute defaults to the `EBAY_CERT_ID` environment
      #   variable.
      %i[app_id dev_id cert_id].each do |method|
        eval <<-DEF, binding, __FILE__, __LINE__ + 1
          attr_writer :#{method}

          def #{method}
            @#{method} || ENV['EBAY_#{method.upcase}']
          end

          @#{method} = nil
        DEF
      end
    end
  end
end
