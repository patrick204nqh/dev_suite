# frozen_string_literal: true

module DevSuite
  module Utils
    module Data
      module PathAccess
        module PathParser
          extend self

          def parse(path)
            return path if path.is_a?(Array)
            return parse_symbol_path(path) if path.is_a?(Symbol)
            return parse_string_path(path) if path.is_a?(String)

            [path]
          end

          private

          def parse_symbol_path(symbol_path)
            symbol_path.to_s.split(/\.|\[|\]/).reject(&:empty?).map { |part| parse_part(part) }
          end

          def parse_string_path(string_path)
            string_path.split(/\.|\[|\]/).reject(&:empty?).map { |part| parse_part(part) }
          end

          def parse_part(part)
            part.match?(/^\d+$/) ? part.to_i : part.to_sym
          end
        end
      end
    end
  end
end
