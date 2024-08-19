module DevSuite
  module RequestLogger
    module Adapter
      class NetHttp < Base
        # Enables the logging of Net::HTTP requests by monkey patching the request method
        def enable
          ::Net::HTTP.class_eval do
            # Alias the original request method with a unique name (_original_request)
            # This preserves the original functionality so it can still be called after logging is added
            alias_method :_original_request, :request

            # Override the request method to add logging functionality
            def request(request, body = nil, &block)
              # Log the full URL of the HTTP request (this can be replaced with more detailed logging)
              puts "#{address}:#{port}#{request.path}"

              # Call the original request method (now aliased as _original_request) to perform the actual HTTP request
              response = _original_request(request, body, &block)

              # This is where you could add logging for the response if needed
              # For example, you could log the status code, headers, and body of the response
              # RequestLogger.log_response(
              #   :http_net,
              #   status: response.code,
              #   headers: response.each_header.to_h,
              #   body: response.body
              # )

              # Return the response object so that the calling code receives the expected result
              response
            end
          end
        end

        # Disables the logging by restoring the original Net::HTTP request method
        def disable
          ::Net::HTTP.class_eval do
            # Restore the original request method by aliasing it back from _original_request
            # This effectively removes the logging functionality and returns Net::HTTP to its original state
            alias_method :request, :_original_request
          end
        end
      end
    end
  end
end
