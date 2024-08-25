# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Hook
          module HookRunner
            private

            # Runs all hooks registered for a given stage
            def run_hooks(stage)
              self.class.hooks[stage]&.each { |hook| instance_eval(&hook) }
            end
          end
        end
      end
    end
  end
end
