module Ebay
  module Config
    class << self
      %i(app_id dev_id cert_id).each do |method|
        eval <<-DEF
          attr_writer :#{method}

          def #{method}
            @#{method} || ENV['EBAY_#{method.upcase}']
          end
        DEF
      end
    end
  end
end
