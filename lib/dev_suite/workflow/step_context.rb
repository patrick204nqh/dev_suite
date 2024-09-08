# frozen_string_literal: true

module DevSuite
  module Workflow
    class StepContext
      attr_accessor :data, :store

      def initialize(data = {}, **options)
        @data = data
        @store = create_store(options)
      end

      # Update the context with new data
      def update(new_data)
        Utils::Data.deep_merge!(@data, new_data)
      end

      # Retrieve data by key
      def get(key)
        Utils::Data.get_value_by_path(@data, key)
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
