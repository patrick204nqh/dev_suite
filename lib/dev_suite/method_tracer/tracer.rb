# frozen_string_literal: true

module DevSuite
  module MethodTracer
    class Tracer
      attr_reader :show_params, :show_results, :show_execution_time, :max_depth
      attr_accessor :current_depth, :trace_point, :start_times

      def initialize(
        show_params: false,
        show_results: false,
        show_execution_time: false,
        max_depth: nil
      )
        @show_params = show_params
        @show_results = show_results
        @show_execution_time = show_execution_time
        @max_depth = max_depth
        @start_times = {}
        @current_depth = 0
      end

      def trace(&block)
        setup_trace_point
        trace_point.enable
        block.call
      ensure
        trace_point&.disable
      end

      private

      def setup_trace_point
        self.trace_point = TracePoint.new(:call, :return) do |tp|
          next if Helpers.internal_call?(tp)

          handle_trace_point_event(tp)
        end
      end

      def handle_trace_point_event(tp)
        case tp.event
        when :call
          handle_call_event(tp)
        when :return
          handle_return_event(tp)
        else
          raise "Unknown event type: #{tp.event}"
        end
      end

      def handle_call_event(tp)
        @current_depth += 1

        if current_depth_within_limit?
          Logger.log_method_call(tp, self)
        end
      end

      def handle_return_event(tp)
        if current_depth_within_limit?
          Logger.log_method_return(tp, self)
        end

        @current_depth -= 1
      end

      def current_depth_within_limit?
        max_depth.nil? || current_depth <= max_depth
      end
    end
  end
end
