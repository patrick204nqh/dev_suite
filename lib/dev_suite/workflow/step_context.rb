# frozen_string_literal: true

module DevSuite
  module Workflow
    class StepContext
      attr_accessor :data, :store

      def initialize(data = {}, **options)
        @data = data
        @store = Utils::Store.create(driver: options[:driver], path: options[:path])
      end

      # Update the context with new data
      def update(new_data)
        Utils::Data.deep_merge!(@data, new_data)
      end

      # Retrieve data by key
      def get(key)
        Utils::Data.get_value_by_path(@data, key)
      end
    end
  end
end
