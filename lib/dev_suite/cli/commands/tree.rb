# frozen_string_literal: true

module DevSuite
  module CLI
    module Commands
      class Tree < Base
        desc "visualize PATH", "Visualize the directory structure at given PATH"
        def execute(path, options: {})
          log("Starting visualization for: #{path}")
          begin
            apply_configure(options)
            visualize(path)

            log("Visualization complete.")
          rescue StandardError => e
            handle_error(e)
          end
        end

        private

        def visualize(path)
          DirectoryTree.visualize(path)
        end

        def apply_configure(options)
          DirectoryTree.configure do |config|
            config.settings.set(:max_depth, options[:depth]) if options[:depth]
            config.settings.set(:skip_hidden, options[:skip_hidden]) if options[:skip_hidden]
            config.settings.set(:skip_types, options[:skip_types]) if options
          end
        end
      end
    end
  end
end
