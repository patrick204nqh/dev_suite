# frozen_string_literal: true

module DevSuite
  module MethodTracer
    module Helpers
      class << self
        def internal_call?(tp)
          tp.path&.include?("<internal:") || tp.defined_class.to_s.start_with?("TracePoint")
        end

        def format_method_name(tp)
          "#{tp.defined_class}##{tp.method_id}"
        end

        def format_params(tp)
          param_values = tp.binding.local_variables.map do |var|
            tp.binding.local_variable_get(var).inspect
          end.join(", ")
          "(#{param_values})"
        end

        def format_result(tp)
          " #=> #{tp.return_value.inspect}"
        end

        def format_execution_time(duration)
          duration ? " in #{duration}ms" : ""
        end

        def calculate_duration(tp, start_times)
          start_time = start_times.delete(tp.method_id)
          start_time ? ((Time.now - start_time) * 1000.0).round(2) : nil
        end

        def calculate_indent(depth)
          "  " * [(depth - 1), 0].max
        end
      end
    end
  end
end
