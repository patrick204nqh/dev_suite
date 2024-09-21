# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Hook
          require_relative "hook_registry"
          require_relative "hook_runner"

          class << self
            def included(base)
              base.extend(HookRegistry)
            end
          end

          include HookRunner
        end
      end
    end
  end
end
