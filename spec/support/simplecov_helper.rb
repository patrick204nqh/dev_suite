# frozen_string_literal: true

unless ENV["DEBUG"]
  require "simplecov"
  SimpleCov.start do
    add_filter "/spec/"           # Ignore spec directory from coverage
    track_files "lib/**/*.rb"     # Only track files in the lib directory
  end
end
