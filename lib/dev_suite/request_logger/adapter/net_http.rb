# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Adapter
      class NetHttp < Base
        # Enables the logging of Net::HTTP requests by monkey patching the request method
        def enable
          ::Net::HTTP.class_eval do
            # Alias the original request method with a unique name (_original_request)
            # This preserves the original functionality so it can still be called after logging is added
            alias_method(:_original_request, :request)

            # Override the request method to add logging functionality
            def request(request, body = nil, &block)
              start_time = Time.now

              Logger.log_request(self, request)

              response = nil
              begin
                # Call the original request method (now aliased as _original_request) to perform the actual HTTP request
                response = _original_request(request, body, &block)
              ensure
                end_time = Time.now
                response ||= Net::HTTPResponse.new("1.1", "500", "Internal Server Error")
                response.instance_variable_set(:@start_time, start_time)
                response.instance_variable_set(:@end_time, end_time)
                response.define_singleton_method(:start_time) { @start_time }
                response.define_singleton_method(:end_time) { @end_time }

                Logger.log_response(self, response)
              end

              response
            end
          end
        end

        # Disables the logging by restoring the original Net::HTTP request method
        def disable
          ::Net::HTTP.class_eval do
            # Restore the original request method by aliasing it back from _original_request
            # This effectively removes the logging functionality and returns Net::HTTP to its original state
            alias_method(:request, :_original_request)
            remove_method(:_original_request)
          end
        end
      end
    end
  end
end
