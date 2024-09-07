# frozen_string_literal: true

module DevSuite
  module Workflow
    class StepContext
      attr_accessor :data, :store

      def initialize(data = {})
        @data = data
        @store = Utils::Store.create(driver: :file)
      end

      # Update the context with new data
      def update(new_data)
        @data.merge!(new_data)
      end

      # Retrieve data by key
      def get(key)
        @data[key]
      end
    end
  end
end
