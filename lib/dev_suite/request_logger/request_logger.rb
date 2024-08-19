module DevSuite
  module RequestLogger
    require_relative "config"
    require_relative "adapter"

    class << self
      def log(&block)
        enable_adapters
        block.call
      ensure
        # Ensure that adapters are disabled even if an exception is raised
        disable_adapters
      end

      private

      def enable_adapters
        Config.configuration.adapters.each(&:enable)
      end

      def disable_adapters
        Config.configuration.adapters.each(&:disable)
      end
    end
  end
end
