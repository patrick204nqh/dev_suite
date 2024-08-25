# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Visualizer
      class Base < Structure::Component
        def visualize(path)
          raise NotImplementedError, "You must implement #{self.class}##{__method}"
        end
      end
    end
  end
end
