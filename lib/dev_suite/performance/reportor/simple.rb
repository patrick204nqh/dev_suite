# frozen_string_literal: true

module DevSuite
  module Performance
    module Reportor
      class Simple < Base
        #
        # Generates the performance report
        #
        # @param description [String] The description of the analysis
        # @param results [Hash] The profiling results from the profilers
        #
        def generate(description:, results:)
          table = Helpers::TableBuilder.build_table(description, results)
          render_table(table)
        end

        private

        #
        # Renders the table using the configured renderer
        #
        # @param table [Utils::Table::Table] The table to render
        #
        def render_table(table)
          renderer = Utils::Table::Config.configuration.renderer
          puts renderer.render(table)
        end
      end
    end
  end
end
