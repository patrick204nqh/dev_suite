# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Palette
        class Base < Utils::Construct::Component::Base
          def colors
            unless self.class.const_defined?(:COLORS)
              raise NotImplementedError, "#{self.class} must define COLORS constant"
            end

            self.class::COLORS
          end
        end
      end
    end
  end
end
