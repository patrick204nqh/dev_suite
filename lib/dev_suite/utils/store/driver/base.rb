# frozen_string_literal: true

module DevSuite
  module Utils
    module Store
      module Driver
        class Base < Construct::Component::Base
          def set(key, value)
            raise NotImplementedError, "Subclasses must implement the `set` method"
          end

          def fetch(key)
            raise NotImplementedError, "Subclasses must implement the `fetch` method"
          end

          def delete(key)
            raise NotImplementedError, "Subclasses must implement the `delete` method"
          end

          def import(source)
            raise NotImplementedError, "Subclasses must implement the `import` method"
          end

          def export(destination)
            raise NotImplementedError, "Subclasses must implement the `export` method"
          end

          def clear
            raise NotImplementedError, "Subclasses must implement the `clear` method"
          end
        end
      end
    end
  end
end
