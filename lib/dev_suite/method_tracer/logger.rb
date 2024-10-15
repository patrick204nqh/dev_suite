# frozen_string_literal: true

module DevSuite
  module MethodTracer
    module Logger
      class << self
        def log_method_call(tp, tracer)
          # Store the start time for execution time calculation
          tracer.start_times[tp.method_id] = Time.now

          message = build_call_message(tp, tracer)
          Utils::Logger.log(message, emoji: :start, color: :blue)
        end

        def log_method_return(tp, tracer)
          duration = Helpers.calculate_duration(tp, tracer.start_times)

          message = build_return_message(tp, tracer, duration)
          Utils::Logger.log(message, emoji: :finish, color: :cyan)
        end

        private

        # Builds the log message for method calls
        #
        # @param tp [TracePoint] The TracePoint object
        # @param tracer [Tracer] The tracer instance
        # @return [String] The formatted log message
        def build_call_message(tp, tracer)
          method_name = colorize_text(Helpers.format_method_name(tp), :blue)
          params_str = tracer.show_params ? colorize_text(Helpers.format_params(tp), :yellow) : ""
          indent = Helpers.calculate_indent(tracer.current_depth)
          depth_str = colorize_text("#depth:#{tracer.current_depth}", :magenta)

          "#{indent}#{depth_str} > #{method_name} at #{tp.path}:#{tp.lineno} #{params_str}"
        end

        # Builds the log message for method returns
        #
        # @param tp [TracePoint] The TracePoint object
        # @param tracer [Tracer] The tracer instance
        # @param duration [Float] The execution time
        # @return [String] The formatted log message
        def build_return_message(tp, tracer, duration)
          method_name = colorize_text(Helpers.format_method_name(tp), :cyan)
          result_str = tracer.show_results ? colorize_text(Helpers.format_result(tp), :green) : ""
          exec_time_str = if tracer.show_execution_time
            colorize_text(
              Helpers.format_execution_time(duration),
              :light_white,
            )
          else
            ""
          end
          indent = Helpers.calculate_indent(tracer.current_depth)
          depth_str = colorize_text("#depth:#{tracer.current_depth}", :magenta)

          "#{indent}#{depth_str} < #{method_name}#{result_str} at #{tp.path}:#{tp.lineno}#{exec_time_str}"
        end

        # Helper method to colorize text
        #
        # @param text [String] The text to colorize
        # @param color [Symbol] The color to use
        # @return [String] The colorized text
        def colorize_text(text, color)
          Utils::Color.colorize(text, color: color)
        end
      end
    end
  end
end
