# frozen_string_literal: true

def require_support_files
  support_files = Dir[File.join(__dir__, "**/*.rb")]

  support_files.each do |file|
    # Exclude any files ending with _spec.rb to avoid loading test files
    next if file.end_with?("_spec.rb")

    require file
  end
end

# Call this method to load support files when this file is required
require_support_files
