# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      class BackupManager
        def initialize(path)
          @path = path
        end

        def create_backup
          backup_path = "#{@path}.bak"
          Logger.log("Creating backup of #{@path} at #{backup_path}", level: :info)
          ::FileUtils.cp(@path, backup_path)
        rescue IOError => e
          raise "Failed to create backup: #{e.message}"
        end
      end
    end
  end
end
