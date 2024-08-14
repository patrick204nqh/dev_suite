# frozen_string_literal: true

module DevSuite
  module CLI
    module Commands
      class Tree < Base
        desc "visualize PATH", "Visualize the directory structure at given PATH"
        def execute(path, options: {})
          Logger.log("Starting visualization for: #{path}", emoji: :start)

          apply_configure(options)
          visualize(path)

          Logger.log("Visualization complete!", emoji: :success)
        rescue StandardError => e
          ErrorHandler.handle_error(e)
        end

        private

        def visualize(path)
          DirectoryTree.visualize(path)
        end

        def apply_configure(options)
          option_config_mapping = {
            depth: :max_depth,
            skip_hidden: :skip_hidden,
            skip_types: :skip_types,
          }

          DirectoryTree::Config.configure do |config|
            option_config_mapping.each do |option_key, config_key|
              value = options[option_key]
              config.settings.set(config_key, value) if value
            end
          end
        end
      end
    end
  end
end
