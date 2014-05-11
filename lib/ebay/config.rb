module Ebay
  module Config
    class << self
      attr_writer :app_id

      def app_id
        @app_id || ENV['EBAY_APP_ID']
      end
    end
  end
end
