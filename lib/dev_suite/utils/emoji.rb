# frozen_string_literal: true

module DevSuite
  module Utils
    module Emoji
      # A frozen hash that contains all the emojis used in the application.
      EMOJIS = {
        start: "🚀",
        success: "✅",
        error: "🚨❌",
        retry: "💥",
        info: "ℹ️",
        warning: "⚠️",
        note: "📝",       # For notes or annotations
        tip: "💡",        # For tips or helpful hints
        important: "❗",  # For important information
        caution: "⚠️", # For warnings or cautions
        document: "📄",   # For representing documents or files
        code: "💻",       # For code or technical content
        update: "🔄",     # For updates or changes
        bug: "🐞",        # For bugs or issues
        fix: "🔧",        # For fixes or repairs
      }.freeze

      class << self
        # Returns the emoji corresponding to the given key.
        # @param key [Symbol] the key to look up the emoji
        # @return [String] the corresponding emoji or an empty string if not found
        def get(key)
          EMOJIS[key] || ""
        end
      end
    end
  end
end
