# frozen_string_literal: true

require 'minitest/autorun'
require 'vcr'

ENV['EBAY_APP_ID'] ||= 'APP_ID'
ENV['EBAY_CERT_ID'] ||= 'CERT_ID'

VCR.configure do |c|
  c.cassette_library_dir = "#{File.dirname(__FILE__)}/cassettes"
  c.default_cassette_options = { match_requests_on: %i[uri body],
                                 record: ENV['RECORD'] ? :once : :none }
  c.hook_into :webmock
  c.filter_sensitive_data('APP_ID') { ENV.fetch('EBAY_APP_ID', nil) }
  c.filter_sensitive_data('CREDENTIALS') do |interaction|
    interaction.request.headers['Authorization']&.first
  end
end
