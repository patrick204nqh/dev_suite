# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      module Formatter
        class TextAligner
          class << self
            def align(text, width, alignment = :left)
              case alignment
              when :left
                text.ljust(width)
              when :right
                text.rjust(width)
              when :center
                text.center(width)
              else
                text
              end
            end
          end
        end
      end
    end
  end
end
