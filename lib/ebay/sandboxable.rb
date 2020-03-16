# frozen_string_literal: true

require 'ebay/config'

module Ebay
  # Allows running requests in the eBay Sandbox
  module Sandboxable
    # Runs requests in the eBay Sandbox
    #
    # @return [self]
    def sandbox
      @sandbox = true
      self
    end

    # @!attribute [r] sandbox?
    # Returns whether requests run in the eBay Sandbox
    #
    # @return [Boolean]
    def sandbox?
      @sandbox ||= false
    end
  end
end
