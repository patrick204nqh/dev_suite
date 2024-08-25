# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Component
        class Base
          class << self
            class << self
              def key
                raise NotImplementedError, "#{name} must define KEY" unless const_defined?(:KEY)

                const_get(:KEY)
              end
            end
          end
        end
      end
    end
  end
end
