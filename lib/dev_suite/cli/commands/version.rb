# frozen_string_literal: true

module DevSuite
  module CLI
    module Commands
      class Version < Base
        def execute
          log("DevSuite version: #{DevSuite::VERSION}")
        end
      end
    end
  end
end
