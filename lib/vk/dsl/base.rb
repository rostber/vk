require 'vk/exceptions'

module Vk
  module DSL
    class Base
      # @param [Vk::Client] client
      # @param [Hash] options
      def initialize(client, options = {})
        @client = client
        @namespace = options.delete(:namespace) { self.class.name.underscore }
        @options = options
      end

      private

      # @param [String] method_name
      # @param [Hash] data
      def request(method_name, data = {})
        @client.request("#{namespace}.#{method_name}", data)
      end

      # @param [String] method
      # @param [Class] items_class
      # @param [Hash] options
      # @param [Hash] merged_attributes
      # @return [Vk::Result]
      def request_for_collection(method, items_class, options = {}, merged_attributes = {})
        Vk::Result.new(method, items_class, options.merge(request: self), merged_attributes)
      end
    end
  end
end
