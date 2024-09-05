# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Base < Utils::Construct::Component::Base
          def write(_path, _content)
            raise NotImplementedError, "Subclasses must implement the `write` method"
          end

          private

          def ensure_directory_exists(path)
            dir = ::File.dirname(path)
            ::FileUtils.mkdir_p(dir) unless ::Dir.exist?(dir)
          end

          def locked_write(path, content)
            File.open(path, "w") do |file|
              file.flock(File::LOCK_EX) # Acquire exclusive lock
              file.write(content)
              file.flush # Ensure content is written before releasing the lock
              file.flock(File::LOCK_UN) # Release the lock
            end
          end
        end
      end
    end
  end
end
