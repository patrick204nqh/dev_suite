# frozen_string_literal: true

module DevSuite
  module MethodTracer
    module Logger
      class << self
        def log_method_call(tp, tracer)
          tracer.depth += 1

          method_name = Helpers.format_method_name(tp)
          params_str = Helpers.format_params(tp) if tracer.show_params
          indent = Helpers.calculate_indent(tracer.depth)

          # Store the start time for execution time calculation
          tracer.start_times[tp.method_id] = Time.now

          message = "#{indent}#depth:#{tracer.depth} > #{method_name} at #{tp.path}:#{tp.lineno} #{params_str}"
          Utils::Logger.log(
            message,
            emoji: :start,
            color: :blue,
          )
        end

        def log_method_return(tp, tracer)
          duration = Helpers.calculate_duration(tp, tracer.start_times)

          method_name = Helpers.format_method_name(tp)
          result_str = Helpers.format_result(tp) if tracer.show_results
          exec_time_str = Helpers.format_execution_time(duration) if tracer.show_execution_time
          indent = Helpers.calculate_indent(tracer.depth)

          message = "#{indent}#depth:#{tracer.depth} < #{method_name}#{result_str} at #{tp.path}:#{tp.lineno}#{exec_time_str}"
          Utils::Logger.log(
            message,
            emoji: :finish,
            color: :cyan,
          )

          # Decrement depth safely
          tracer.depth = [tracer.depth - 1, 0].max
        end
      end
    end
  end
end
