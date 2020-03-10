# frozen_string_literal: true

module Ebay
  module Config
    class << self
      %i(app_id dev_id cert_id).each do |method|
        eval <<-DEF, binding, __FILE__, __LINE__ + 1
          attr_writer :#{method}

          def #{method}
            @#{method} || ENV['EBAY_#{method.upcase}']
          end
        DEF
      end
    end
  end
end
