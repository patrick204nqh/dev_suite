# frozen_string_literal: true

require_relative "column/column"
require_relative "row/row"
require_relative "renderer"
require_relative "config"

module DevSuite
  module Utils
    module Table
      class Table
        attr_accessor :title
        attr_reader :columns, :rows, :config

        def initialize(config = Config.new)
          @columns = []
          @rows = []
          @title = ""
          @config = config
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

        def render(renderer: Renderer::Simple.new(config))
          renderer.render(self)
        end
      end
    end
  end
end
