# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Builder
      require_relative "builder/base"

      include Utils::Construct::ComponentManager

      register_component(:base, Base)
    end
  end
end
