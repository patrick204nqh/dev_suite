# frozen_string_literal: true

module DevSuite
  module MethodTracer
    module Config
      class Configuration < Utils::Construct::Config::Base
        set_default_settings(
          show_params: false,
          show_results: false,
          show_execution_time: false,
          max_depth: nil,
        )
      end
    end
  end
end
