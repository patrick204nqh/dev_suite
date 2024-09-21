# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Hook
          module HookRegistry
            # Registers a hook for a specific stage
            def register_hook(stage, &block)
              hooks[stage] ||= []
              hooks[stage] << block
            end

            # Retrieves the hooks registered for this class
            def hooks
              @hooks ||= {}
            end
          end
        end
      end
    end
  end
end
