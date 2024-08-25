# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Attribute
          require_relative "attr_definition"
          require_relative "attr_initialization"
          require_relative "attr_resolving"

          class << self
            def included(base)
              base.extend(AttrDefinition)
            end
          end

          include AttrInitialization
          include AttrResolving
        end
      end
    end
  end
end
