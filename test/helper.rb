# frozen_string_literal: true

require 'minitest/autorun'
require 'vcr'

ENV['EBAY_APP_ID'] ||= 'APP_ID'
ENV['EBAY_CERT_ID'] ||= 'CERT_ID'

VCR.configure do |c|
  c.cassette_library_dir = File.dirname(__FILE__) + '/cassettes'
  c.default_cassette_options = { record: :none }
  c.hook_into :webmock
  c.before_record { |http| http.ignore! if http.response.status.code >= 300 }
  c.filter_sensitive_data('APP_ID') { ENV['EBAY_APP_ID'] }
  c.filter_sensitive_data('CREDENTIALS') do |interaction|
    interaction.request.headers['Authorization'].first
  end
end

module Minitest
  class Test
    def assert_success(response)
      data = JSON.parse(response)

      ack = data['Ack']
      ack ||= data.values.flatten.first['ack']
      ack = ack.first if ack.is_a?(Array)

      assert_equal 'Success', ack
    end
  end
end
