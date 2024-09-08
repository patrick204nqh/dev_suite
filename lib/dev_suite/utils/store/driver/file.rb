# frozen_string_literal: true

module DevSuite
  module Utils
    module Store
      module Driver
        class File < Base
          def initialize(**options)
            super()
            @path = options[:path] || fetch_setting(:path, default: "tmp/store.json")
            @data = {}
            load_data
          end

          def set(key, value)
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
            @data = FileLoader.load(@path) if ::File.exist?(@path)
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
