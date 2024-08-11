# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Builder
      require_relative "builder/base"

      class << self
        def create(type)
          case type
          when :base
            Base.new
          else
            raise ArgumentError, "Unknown renderer type: #{type}"
          end
        end
      end
    end
  end
end
