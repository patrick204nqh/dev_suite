# frozen_string_literal: true

module DevSuite
  module Workflow
    class StepContext
      attr_reader :data, :store

      def initialize(data = {}, **options)
        @data = data
        @store = create_store(options)
      end

      # Update the context with new data
      def update(new_data)
        unless new_data.is_a?(Hash) || new_data.is_a?(Array)
          raise ArgumentError, "New data must be a Hash"
        end

        Utils::Data.deep_merge!(@data, new_data)
      end

      # Set data by key
      def set(key, value)
        Utils::Data.set_value_by_path(@data, key, value)
      end

      # Retrieve data by key
      def get(key)
        Utils::Data.get_value_by_path(@data, key)
      end

      # Clear the context data
      def clear
        @data.clear # Reset the context data
      end

      private

      def create_store(options)
        driver = options[:driver] || :file
        path = options[:path]
        Utils::Store.create(driver: driver, path: path)
      end
    end
  end
end
