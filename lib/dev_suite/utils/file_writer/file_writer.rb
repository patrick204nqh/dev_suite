# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      require_relative "atomic_writer"
      require_relative "backup_manager"
      require_relative "writer"
      require_relative "writer_manager"

      class << self
        def write(path, content)
          WriterManager.write(path, content)
        end

        def append(path, content)
          WriterManager.append(path, content)
        end

        def delete_lines(path, start_line, end_line = start_line)
          WriterManager.delete_lines(path, start_line, end_line)
        end

        def update_key(path, key, value)
          WriterManager.update_key(path, key, value)
        end

        def delete_key(path, key)
          WriterManager.delete_key(path, key)
        end
      end
    end
  end
end
