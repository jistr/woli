if ENV['DEBUG']
  require 'pry'
end
require "woli/config"
require "woli/diary"
require "woli/diary_entry"
require "woli/version"
require "woli/repositories/files"

module Woli
  def self.config
    @config ||= Woli::Config.load_user_config
  end

  def self.diary
    @diary ||= initialize_diary
  end

  def self.editor
    config['editor'] || ENV['EDITOR'] || 'vim'
  end

  class << self
    private
    def initialize_diary
      repository_class = config['repository_class'].split('::').reduce(Kernel) do |result_const, nested_const|
        result_const = result_const.const_get(nested_const.to_sym)
      end
      repository = repository_class.new(config['repository_config'])
      Woli::Diary.new(repository)
    end
  end
end
