module DevSuite
  module Utils
    module Table
      class ColumnWidthCalculator
        def initialize(headings, rows)
          @headings = headings
          @rows = rows
        end

        def calculate
          column_widths = @headings.map(&:length)
          @rows.each do |row|
            row.each_with_index do |cell, index|
              column_widths[index] = [column_widths[index], cell.to_s.length].max
            end
          end
          column_widths
        end
      end
    end
  end
end
