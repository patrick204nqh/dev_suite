# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    class Settings
      include Utils::ConfigTools::Settings

      def default_settings
        {
          skip_hidden: false,
          skip_types: [],
          max_depth: nil,
        }
      end

      def skip_hidden?
        get(:skip_hidden)
      end

      def skip_types
        get(:skip_types)
      end

      def max_depth
        get(:max_depth)
      end
    end
  end
end
