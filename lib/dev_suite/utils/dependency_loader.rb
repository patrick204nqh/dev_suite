# frozen_string_literal: true

module DevSuite
  module Utils
    module DependencyLoader
      class << self
        # Public method to safely load multiple dependencies.
        # Executes the given block if all dependencies are successfully loaded.
        # Calls the on_failure handler with the list of missing dependencies if any are not found.
        #
        # @param dependencies [Array<String>] List of gem names to load.
        # @param on_failure [Proc] Handler to call with missing dependencies if any are not found.
        # @yield Executes the block if all dependencies are loaded.
        def safe_load_dependencies(*dependencies, on_failure: method(:default_failure_handler))
          missing_dependencies = find_missing_dependencies(dependencies)

          if missing_dependencies.empty?
            yield if block_given?
          else
            on_failure.call(missing_dependencies)
          end
        end

        # Check if a gem is installed by attempting to require it.
        #
        # @param gem_name [String] The name of the gem to check.
        # @return [Boolean] true if the gem is installed, false otherwise.
        def gem_installed?(gem_name)
          require gem_name
          true
        rescue LoadError
          false
        end

        private

        # Finds and returns a list of missing dependencies from the provided list.
        #
        # @param dependencies [Array<String>] List of gem names to check.
        # @return [Array<String>] List of missing dependencies.
        def find_missing_dependencies(dependencies)
          dependencies.reject { |gem_name| gem_installed?(gem_name) }
        end

        # Default failure handler that logs missing dependencies.
        #
        # @param missing_dependencies [Array<String>] List of missing dependencies.
        def default_failure_handler(missing_dependencies)
          missing_dependencies.each do |gem_name|
            log_missing_dependency(gem_name)
          end
        end

        # Logs a warning about a missing dependency.
        #
        # @param gem_name [String] The name of the missing gem.
        def log_missing_dependency(gem_name)
          gem_simple_name = gem_name.split("/").last.capitalize
          message = "#{gem_simple_name} gem not installed. Please add `gem '#{gem_simple_name.downcase}'` " \
            "to your Gemfile and run `bundle install`."

          Utils::Logger.log(
            message,
            level: :warn,
            emoji: :warning,
          )
        end
      end
    end
  end
end
