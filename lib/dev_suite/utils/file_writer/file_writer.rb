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
          writer = WriterManager.new
          writer.write(path, content)
        end

        def update_key(path, key, value)
          writer = WriterManager.new
          writer.update_key(path, key, value)
        end
      end
    end
  end
end
