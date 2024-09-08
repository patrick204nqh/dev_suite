# frozen_string_literal: true

require "json"
require "csv"

module DevSuite
  module Utils
    module Data
      module Serialization
        # Convert a hash or array of hashes to compact JSON
        def to_json(data)
          return if data.nil?

          JSON.generate(data) # Use JSON.generate for compact output
        end

        # Convert an array of hashes to CSV format
        def to_csv(array_of_hashes)
          return "" if array_of_hashes.empty?

          CSV.generate do |csv|
            csv << array_of_hashes.first.keys # Header row
            array_of_hashes.each { |hash| csv << hash.values }
          end
        end
      end
    end
  end
end
