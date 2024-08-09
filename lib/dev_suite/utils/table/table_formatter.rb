# frozen_string_literal: true

require_relative "table_renderer"

module DevSuite
  module Utils
    module Table
      class TableFormatter
        def initialize
          @rows = []
        end

        def set_title(title, color: :default)
          @title = title
          @title_color = color
        end

        def set_headings(headings, color: :default)
          @headings = headings
          @headings_color = color
        end

        def add_row(row)
          @rows << row
        end

        def to_table
          renderer = TableRenderer.new(@headings, @rows, {
            title: @title,
            title_color: @title_color,
            headings_color: @headings_color,
            border_color: :blue,
          })
          renderer.render
        end
      end
    end
  end
end
