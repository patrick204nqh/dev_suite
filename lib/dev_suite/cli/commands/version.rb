# frozen_string_literal: true

module DevSuite
  module CLI
    module Commands
      class Version < Base
        def execute
          Logger.log("DevSuite version: #{DevSuite::VERSION} is live!", emoji: :start)
        end
      end
    end
  end
end
