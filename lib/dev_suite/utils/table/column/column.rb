# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      class Column
        attr_reader :name

        def initialize(name)
          @name = name
        end
      end
    end
  end
end
