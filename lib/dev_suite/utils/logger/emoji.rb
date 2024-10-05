# frozen_string_literal: true

module DevSuite
  module Utils
    module Logger
      module Emoji
        class << self
          def resolve(emoji)
            return "" unless emoji

            emoji.is_a?(Symbol) ? Utils::Emoji.get(emoji) : emoji
          end
        end
      end
    end
  end
end
