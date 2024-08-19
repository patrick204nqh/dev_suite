# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Hook
          module Manager
            class << self
              def included(base)
                base.extend(ClassMethods)
              end
            end

            module ClassMethods
              def register_hook(stage, &block)
                hooks[stage] ||= []
                hooks[stage] << block
              end

              def hooks
                @hooks ||= {}
              end
            end

            private

            def run_hooks(stage)
              self.class.hooks[stage]&.each { |hook| instance_eval(&hook) }
            end
          end
        end
      end
    end
  end
end
