# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Extractor
      class Base
        def extract_request(native_request)
          raise NotImplementedError
        end

        def extract_response(native_response)
          raise NotImplementedError
        end
      end
    end
  end
end
