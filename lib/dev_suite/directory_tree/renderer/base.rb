# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Renderer
      class Base
        attr_reader :settings

        def initialize(settings: Settings.new)
          @settings = settings
        end

        def render
          raise NotImplementedError
        end
      end
    end
  end
end
