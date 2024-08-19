# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Adapter
      class Base
        def enable
          raise NotImplementedError
        end

        def disable
          raise NotImplementedError
        end
      end
    end
  end
end
