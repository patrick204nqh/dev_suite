# frozen_string_literal: true

module DevSuite
  module Utils
    module Store
      module Driver
        class Memory < Base
          def initialize
            super
            @data = {}
          end

          def store(key, value)
            @data[key] = value
          end

          def fetch(key)
            @data[key]
          end

          def delete(key)
            @data.delete(key)
          end

          def clear
            @data.clear
          end

          def import(source)
            raise ArgumentError, "The file does not exist" unless ::File.exist?(source)

            @data = FileLoader.load(source)
          end

          def export(destination)
            FileWriter.write(destination, @data)
          end
        end
      end
    end
  end
end
