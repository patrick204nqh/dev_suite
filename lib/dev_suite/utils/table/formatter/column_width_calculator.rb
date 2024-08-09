# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      module Formatter
        class ColumnWidthCalculator
          class << self
            def calculate(columns, rows)
              column_widths = columns.map { |column| column.name.length }
              rows.each do |row|
                row.data.each_with_index do |cell, index|
                  column_widths[index] = [column_widths[index], cell.to_s.length].max
                end
              end
              column_widths
            end
          end
        end
      end
    end
  end
end
