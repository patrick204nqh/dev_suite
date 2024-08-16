# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      require_relative "column"
      require_relative "row"
      require_relative "config"
      require_relative "settings"
      require_relative "formatter"
      require_relative "renderer"

      class Table
        attr_accessor :title
        attr_reader :columns, :rows

        def initialize
          @columns = []
          @rows = []
        end

        def add_columns(*names)
          names.each { |name| add_column(name) }
        end

        def add_column(name)
          @columns << Column.new(name)
        end

        def add_row(data)
          @rows << Row.new(data)
        end
      end
    end
  end
end
