# frozen_string_literal: true

module DevSuite
  module CLI
    module Commands
      class Tree < Base
        desc "visualize PATH", "Visualize the directory structure at given PATH"
        def execute(path)
          log("Starting visualization for: #{path}")
          begin
            # Assume visualize_path is a method that can raise exceptions
            DirectoryTree.visualize(path)
            log("Visualization complete.")
          rescue StandardError => e
            handle_error(e)
          end
        end
      end
    end
  end
end
