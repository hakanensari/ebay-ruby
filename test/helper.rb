# frozen_string_literal: true

require 'minitest/autorun'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = File.dirname(__FILE__) + '/cassettes'
  c.default_cassette_options = { record: :new_episodes }
  c.hook_into :excon
  c.before_record { |http| http.ignore! if http.response.status.code >= 400 }
  c.filter_sensitive_data('APP_ID') { Ebay::Config.app_id }
end
