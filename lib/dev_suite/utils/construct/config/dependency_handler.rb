# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module DependencyHandler
          # Use a lazy initializer in the getter method
          def missing_dependencies
            @missing_dependencies ||= []
          end

          def remove_failed_dependency(attr_name, option_key, *missing_dependencies)
            track_missing_dependency(missing_dependencies)

            attribute = send(attr_name)

            if attribute.is_a?(Array) && attribute.include?(option_key)
              attribute.delete(option_key)
              log_missing_dependency(attr_name, option_key, missing_dependencies)
            end
          end

          private

          def track_missing_dependency(missing_dependencies)
            @missing_dependencies ||= []
            @missing_dependencies += missing_dependencies
          end

          def log_missing_dependency(attr_name, option_key, missing_dependencies)
            missing_dependencies.each do |dependency|
              log_warning("Missing dependency: #{dependency}. " \
                "Please add `gem '#{dependency}'` to your Gemfile and run `bundle install`.")
              log_warning("Deleted option #{option_key} from `config.#{attr_name}`")
            end
          end

          def log_warning(message)
            Utils::Logger.log(message, level: :warn, emoji: :warning)
          end
        end
      end
    end
  end
end
