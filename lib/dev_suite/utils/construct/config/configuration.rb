# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        class Configuration < Base
          class << self
            # Ensure that default configuration attributes are applied to subclasses.
            def inherited(subclass)
              subclass.set_default_settings
              super
            end

            # Define default settings for the class.
            def set_default_settings(settings = {})
              config_attr(:settings, default_value: settings, type: :hash, resolver: ->(value) { Settings.new(value) })
            end

            # Register hooks for different stages
            def register_hook(stage, &block)
              hooks[stage] ||= []
              hooks[stage] << block
            end

            # Store hooks in a class-level hash
            def hooks
              @hooks ||= {}
            end
          end

          def initialize
            run_hooks(:before_initialize)
            super
            run_hooks(:after_initialize)
          end

          private

          # Define a generic hook runner.
          def run_hooks(stage)
            self.class.hooks[stage]&.each { |hook| instance_eval(&hook) }
          end
        end
      end
    end
  end
end
