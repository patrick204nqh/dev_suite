# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Builder
      include Utils::Construct::Component::Manager

      require_relative "base"

      register_component(Base)
    end
  end
end
