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
          max_size: 100 * 1024 * 1024, # 100 MB
          # exclude: [],
          # include: [],
        }
      end
    end
  end
end
