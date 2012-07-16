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
    @config ||= Woli::Config.load_config
  end

  def self.diary
    @diary ||= Woli::Diary.new(self.repository)
  end

  def self.editor
    config['editor'] || ENV['EDITOR'] || 'vim'
  end

  def self.repository
    @repository ||= instantiate_repository
  end

  class << self
    private
    def instantiate_repository
      repository_class = config['repository_class'].split('::').reduce(Kernel) do |result_const, nested_const|
        result_const = result_const.const_get(nested_const.to_sym)
      end
      repository_class.new(config['repository_config'])
    end
  end
end
