# frozen_string_literal: true

require_relative "../color/colorizer"
require_relative "column_width_calculator"

module DevSuite
  module Utils
    module Table
      class TableRenderer
        def initialize(headings, rows, options = {})
          @headings = headings
          @rows = rows
          @colorizer = Color::Colorizer.new
          @options = {
            title: "",
            title_color: :default,
            headings_color: :default,
            border_color: :default,
          }.merge(options)
          @column_widths = ColumnWidthCalculator.new(@headings, @rows).calculate
        end

        def render
          table = []
          table << format_title if @options[:title]
          table << format_separator
          table << format_row(@headings, @options[:headings_color])
          table << format_separator
          @rows.each do |row|
            table << format_row(row)
          end
          table << format_separator
          table.join("\n")
        end

        private

        def format_title
          total_width = @column_widths.sum + @column_widths.size * 3 - 1
          title_str = "| #{@options[:title].center(total_width)} |"
          @colorizer.colorize(title_str, @options[:title_color])
        end

        def format_separator
          separator = @column_widths.map { |width| "-" * width }.join("-+-")
          @colorizer.colorize("+-#{separator}-+", @options[:border_color])
        end

        def format_row(cells, color = :default)
          formatted_cells = cells.each_with_index.map do |cell, index|
            cell.to_s.ljust(@column_widths[index])
          end
          row_str = "| #{formatted_cells.join(" | ")} |"
          @colorizer.colorize(row_str, color)
        end
      end
    end
  end
end
