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

            def remove_failed_dependency(attr_name, option_key, *missing_dependencies)
              attribute = send(attr_name)

              # Ensure the attribute is an array and contains the option_key
              return unless attribute.is_a?(Array) && attribute.include?(option_key)

              # Delete the option_key from the attribute
              attribute.delete(option_key)

              # Log the missing dependency and track it
              log_missing_dependency(attr_name, option_key, missing_dependencies)
              track_missing_dependency(missing_dependencies)
            end

            private

            def track_missing_dependency(missing_dependencies)
              @missing_dependencies = missing_dependencies
            end

            def log_missing_dependency(attr_name, option_key, missing_dependencies)
              missing_dependencies.each do |dependency|
                Utils::Logger.log(
                  "Missing dependency: #{dependency}. " \
                    "Please add `gem '#{dependency}'` to your Gemfile and run `bundle install`.",
                  level: :warn,
                  emoji: :warning,
                )

                Utils::Logger.log(
                  "Deleting option #{option_key} from `config.#{attr_name}`",
                  level: :warn,
                  emoji: :warning,
                )
              end
            end
          end
        end
      end
    end
  end
end
