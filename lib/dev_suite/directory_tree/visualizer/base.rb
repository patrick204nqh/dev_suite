# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Visualizer
      class Base < Utils::Construct::Component::Base
        def visualize(path)
          raise NotImplementedError, "You must implement #{self.class}##{__method}"
        end
      end
    end
  end
end
