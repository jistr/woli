require "woli/config"
require "woli/diary"
require "woli/diary_entry"
require "woli/version"

module Woli
  def self.config
    @config ||= Woli::Config.load_user_config
  end

  def self.diary_path
    File.expand_path(@config['diary_path'])
  end
end
