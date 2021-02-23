# frozen_string_literal: true

require 'minitest/autorun'
require 'vcr'

ENV['EBAY_APP_ID'] ||= 'APP_ID'
ENV['EBAY_CERT_ID'] ||= 'CERT_ID'

VCR.configure do |c|
  c.cassette_library_dir = "#{File.dirname(__FILE__)}/cassettes"
  c.default_cassette_options = { record: :none,
                                 match_requests_on: %i[uri body] }
  c.hook_into :webmock
  c.before_record { |http| http.ignore! if http.response.status.code >= 300 }
  c.filter_sensitive_data('APP_ID') { ENV['EBAY_APP_ID'] }
  c.filter_sensitive_data('CREDENTIALS') do |interaction|
    interaction.request.headers['Authorization']&.first
  end
end
