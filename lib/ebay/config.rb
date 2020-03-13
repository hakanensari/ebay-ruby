# frozen_string_literal: true

module Ebay
  # Stores credentials for accessing the eBay APIs
  module Config
    %i[app_id dev_id cert_id].each do |method|
      eval <<-DEF, binding, __FILE__, __LINE__ + 1
        class << self
          attr_writer :#{method}

          def #{method}
            @#{method} || ENV['EBAY_#{method.upcase}']
          end
        end

        @#{method} = nil
      DEF
    end
  end
end
