# frozen_string_literal: true

module DevSuite
  module Utils
    module Emoji
      # Status-related emojis
      STATUS = {
        start: "🚀",
        success: "✅",
        error: "🚨❌",
        retry: "💥",
        warning: "⚠️", # For warnings
        caution: "🟡", # For caution or proceed with care
        pending: "🕒", # For pending or waiting
        paused: "⏸️",  # For paused or halted
        running: "🏃",  # For running or in progress
        done: "🎉",     # For done or completed
        finish: "🏁",   # For finish or end
        stop: "🛑",     # For stopping or halting
        cancel: "🚫",   # For canceling or aborting
        skip: "⏭️",    # For skipping or jumping
        next: "⏩",     # For next or moving forward
        previous: "⏪", # For previous or moving backward
        up: "⬆️",      # For up or moving up
        down: "⬇️",    # For down or moving down
        left: "⬅️",    # For left or moving left
        right: "➡️",   # For right or moving right
        top: "🔝",      # For top or highest
        bottom: "🔚",   # For bottom or lowest
        middle: "🔽", # For middle or center
        full: "🔴",     # For full or maximum
        empty: "⚪",    # For empty or minimum
      }.freeze

      # Action-related emojis
      ACTIONS = {
        update: "🔄",     # For updates or changes
        fix: "🔧",        # For fixes or repairs
        bug: "🐞",        # For bugs or issues
        code: "💻",       # For code or technical content
      }.freeze

      # Notification-related emojis
      NOTIFICATIONS = {
        info: "ℹ️",
        important: "❗",
        note: "📝",       # For notes or annotations
        tip: "💡",        # For tips or helpful hints
      }.freeze

      # Resource-related emojis
      RESOURCES = {
        document: "📄",   # For representing documents or files
        network: "🌐",    # For network-related logs
        database: "💾",   # For database-related logs
        cache: "🗄️",     # For cache-related logs
        file: "📁",       # For file-related logs
        cookie: "🍪",     # For cookie-related logs
        header: "📑",     # For header-related logs
        request: "📤",    # For request-related logs
        response: "📥",   # For response-related logs
      }.freeze

      DEFAULT_EMOJI = "❓"

      EMOJIS = STATUS.merge(ACTIONS).merge(NOTIFICATIONS).merge(RESOURCES).freeze

      class << self
        # Returns the emoji corresponding to the given key.
        # @param key [Symbol] the key to look up the emoji
        # @param default [String] the default emoji if the key is not found
        # @return [String] the corresponding emoji or the default emoji
        def get(key, default: DEFAULT_EMOJI)
          EMOJIS[key] || default
        end

        # Returns all emojis categorized by their purpose.
        # @return [Hash] a hash containing all emojis organized by categories.
        def all
          {
            status: STATUS,
            actions: ACTIONS,
            notifications: NOTIFICATIONS,
            resources: RESOURCES,
          }
        end
      end
    end
  end
end
