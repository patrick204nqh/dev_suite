# frozen_string_literal: true

module DevSuite
  module Performance
    module Profiler
      class Base < Structure::Component
        def run(&block)
          raise NotImplementedError, "Subclasses must implement the run method"
        end

        def stats
          raise NotImplementedError, "Subclasses must implement the stats method"
        end
      end
    end
  end
end
