# frozen_string_literal: true

module DevSuite
  module CLI
    module Commands
      class Base < Thor
        include Logger
        include ErrorHandler

        desc "execute", "Execute the command"
        def execute
          raise NotImplementedError
        end
      end
    end
  end
end
