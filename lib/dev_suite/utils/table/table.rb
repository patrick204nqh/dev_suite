# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      class Table
        attr_accessor :title
        attr_reader :columns, :rows, :config

        def initialize(config = Config.configuration)
          @config = config
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

        def render
          @config.renderer.render(self)
        end
      end
    end
  end
end
