module Woli
  class Cli
    desc 'init', 'Initialize Woli for this user.'
    long_desc <<-END
      Creates a ~/.woli directory with Woli configuration.
    END
    def init
      created_config_file_path = Woli::Config.create_default_config_file
      if created_config_file_path
        puts "Default config file created at #{created_config_file_path}."
      else
        puts "Config file already exists."
      end
    end
  end
end