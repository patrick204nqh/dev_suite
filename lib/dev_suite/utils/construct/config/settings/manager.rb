# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Settings
          module Manager
            class << self
              def included(base)
                base.extend(ClassMethods)
              end
            end

            module ClassMethods
              # Ensure that default configuration attributes are applied to subclasses.
              def inherited(subclass)
                subclass.set_default_settings
                super
              end

              # Define default settings for the class.
              def set_default_settings(settings = {})
                config_attr(:settings, default_value: settings, type: :hash, resolver: :resolve_settings)
              end
            end

            private

            def resolve_settings(value)
              Base.new(value)
            end
          end
        end
      end
    end
  end
end
