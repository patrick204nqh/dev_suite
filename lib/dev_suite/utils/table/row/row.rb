# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      class Row
        attr_reader :data

        def initialize(data)
          @data = data
        end
      end
    end
  end
end
