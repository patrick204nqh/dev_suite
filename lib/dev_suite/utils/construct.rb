# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      # The Construct module serves as a namespace for reusable constructs that
      # provide foundational utilities, such as configuration management, which
      # can be included in other modules throughout the DevSuite framework.
      #
      # This module centralizes shared functionality to promote code reuse,
      # maintainability, and consistency across different modules.

      require_relative "construct/construct"
    end
  end
end
