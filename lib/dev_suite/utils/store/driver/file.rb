# frozen_string_literal: true

module DevSuite
  module Utils
    module Store
      module Driver
        class File < Base
          def initialize
            super
            @path = fetch_setting("driver.file.path")
            @data = {}
            load_data if ::File.exist?(@path)
          end

          def store(key, value)
            @data[key] = value
            save_data
          end

          def fetch(key)
            @data[key]
          end

          def delete(key)
            @data.delete(key)
            save_data
          end

          def clear
            @data = {}
            save_data
          end

          def import(source)
            raise ArgumentError, "The file does not exist" unless ::File.exist?(source)

            @data = FileLoader.load(source)
          end

          def export(destination)
            FileWriter.write(destination, @data)
          end

          private

          def load_data
            @data = FileLoader.load(@path)
          end

          def save_data
            FileWriter.write(@path, @data)
          end

          def fetch_setting(key, default: nil)
            Config.configuration.settings.get(key, default: default)
          end
        end
      end
    end
  end
end
