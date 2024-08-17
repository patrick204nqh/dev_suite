# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Renderer
      class Base
        def render
          raise NotImplementedError
        end
      end
    end
  end
end
