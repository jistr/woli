require 'yaml'

module Woli
  module Config
    CONFIG_FILE_NAME = "#{ENV['HOME']}/.woli/config.yml"
    CONFIG_TEMPLATE_FILE_NAME = File.join(File.dirname(__FILE__),
                                         '../../templates/default_config.yml')

    def self.load_config
      if File.exists?(CONFIG_FILE_NAME)
        YAML.load_file(CONFIG_FILE_NAME)
      else
        raise ConfigError, "Woli not yet initialized. Run 'woli help init' for more info."
      end
    end

    def self.create_config_file_from_template
      unless File.exists?(CONFIG_FILE_NAME)
        FileUtils.mkdir_p(File.dirname(CONFIG_FILE_NAME))
        FileUtils.cp(CONFIG_TEMPLATE_FILE_NAME, CONFIG_FILE_NAME)
        CONFIG_FILE_NAME
      else
        nil
      end
    end
  end

  class ConfigError < RuntimeError
  end
end
