module DevSuite
  module Performance
    module Profiling
      class BaseProfiler
        def run(&block)
          raise NotImplementedError, 'Subclasses must implement the run method'
        end
      end
    end
  end
end
