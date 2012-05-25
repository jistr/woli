require 'yaml'

module Woli
  class Config
    CONFIG_FILE_NAME = "#{ENV['HOME']}/.woli/config.yml"
    DEFAULT_CONFIG_FILE_NAME = File.join(File.dirname(__FILE__), '../../templates/default_config.yml')

    def self.load_user_config
      create_default_config_file(CONFIG_FILE_NAME) unless File.exist?(CONFIG_FILE_NAME)
      YAML.load_file(CONFIG_FILE_NAME)
    end

    def self.create_default_config_file(file_name)
      FileUtils.mkdir_p(File.dirname(file_name))
      FileUtils.cp(DEFAULT_CONFIG_FILE_NAME, file_name)
    end
  end
end
