# frozen_string_literal: true

module FileHelper
  def read_file_content(path, file_type)
    case file_type
    when :txt
      File.read(path).strip
    when :json
      JSON.parse(File.read(path))
    when :yaml
      YAML.load_file(path)
    end
  end

  def append_expected_content(original_content, append_content, file_type)
    case file_type
    when :txt
      "#{original_content.strip}\n#{append_content.strip}"
    when :json, :yaml
      original_content.merge(append_content)
    end
  end
end

RSpec.configure do |config|
  config.include(FileHelper)
end
