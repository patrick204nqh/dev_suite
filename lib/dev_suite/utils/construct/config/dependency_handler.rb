# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module DependencyHandler
          class << self
            def included(base)
              base.class_eval do
                attr_accessor(:missing_dependencies)
              end
              base.include(InstanceMethods)
            end
          end

          module InstanceMethods
            def initialize(*args)
              super
              @missing_dependencies ||= []
            end

            def delete_option_on_failure(attr_name, option_key, *missing_dependencies)
              message = "Deleting option #{option_key} from #{attr_name} due to missing dependencies: "
              message += missing_dependencies.join(", ")
              puts message

              send(attr_name).delete(option_key)
              track_missing_dependency(missing_dependencies)
            end

            private

            def track_missing_dependency(missing_dependencies)
              @missing_dependencies = missing_dependencies
            end
          end
        end
      end
    end
  end
end
