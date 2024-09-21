# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Attribute
          module AttrInitialization
            private

            # Initializes all configuration attributes with their default values
            def initialize_config_attrs
              self.class.config_attrs.each do |attr, details|
                send("#{attr}=", details[:default_value]) unless instance_variable_defined?("@#{attr}")
              end
            end
          end
        end
      end
    end
  end
end
