# frozen_string_literal: true

module DevSuite
  module MethodTracer
    class Tracer
      attr_reader :show_params, :show_results, :show_execution_time, :max_depth
      attr_accessor :depth, :trace_point, :start_times

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
        @depth = 0
        @start_times = {}
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
        end
      end

      def handle_call_event(tp)
        Logger.log_method_call(tp, self) if depth_within_limit?
      end

      def handle_return_event(tp)
        Logger.log_method_return(tp, self) if depth_within_limit?
      end

      def depth_within_limit?
        max_depth.nil? || @depth < max_depth
      end
    end
  end
end
