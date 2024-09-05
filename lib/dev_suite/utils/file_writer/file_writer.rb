# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      require_relative "writer"
      require_relative "writer_manager"

      class << self
        def write(path, content)
          writer = WriterManager.new
          writer.write(path, content)
        end
      end
    end
  end
end
