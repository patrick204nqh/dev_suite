# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      module Renderer
        class Simple < Base
          def render(table)
            column_widths = calculate_column_widths(table)

            [
              render_title(table, column_widths),
              render_separator(column_widths),
              render_header(table, column_widths),
              render_separator(column_widths),
              render_rows(table, column_widths),
            ].compact.join("\n")
          end

          private

          def settings
            Config.configuration.settings
          end

          #
          # Calculates the widths of the columns
          #
          def calculate_column_widths(table)
            Formatter::ColumnWidthCalculator.calculate(table.columns, table.rows)
          end

          #
          # Colorizes the given string with the specified color
          #
          def colorize(str, color)
            Utils::Color.colorize(str, color: color)
          end

          #
          # Aligns the given string to the specified width
          #
          def text_align(str, width)
            Formatter::TextAligner.align(str, width)
          end

          def render_title(table, column_widths)
            return if table.title.nil? || table.title.strip.empty?

            total_width = column_widths.sum + column_widths.size * 3 - 1
            title_str = "| #{table.title.center(total_width - 2)} |"
            colorize(title_str, settings.color_for(:title))
          end

          def render_header(table, column_widths)
            return if table.columns.empty?

            header = table.columns.map.with_index do |column, index|
              text_align(column.name, column_widths[index])
            end
            header_str = "| #{header.join(" | ")} |"
            colorize(header_str, settings.color_for(:column))
          end

          def render_separator(column_widths)
            separator = column_widths.map { |width| "-" * width }.join("-+-")
            separator_str = "+-#{separator}-+"
            colorize(separator_str, settings.color_for(:border))
          end

          def render_rows(table, column_widths)
            cells = table.rows.map do |row|
              render_row(row, column_widths)
            end
            cells_str = cells.join("\n")
            colorize(cells_str, settings.color_for(:row))
          end

          def render_row(row, column_widths)
            cell = row.data.map.with_index do |cell, index|
              text_align(cell.to_s, column_widths[index])
            end
            cell_str = "| #{cell.join(" | ")} |"
            colorize(cell_str, settings.color_for(:row))
          end
        end
      end
    end
  end
end
