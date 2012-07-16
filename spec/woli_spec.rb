require_relative 'spec_helper'
require 'woli'

describe Woli do
  describe ".config" do
    after do
      module Woli
        @config = nil
      end
    end

    it "returns config when already loaded" do
      module Woli
        @config = :fake_config
      end
      Woli.config.must_equal :fake_config
    end

    it "loads config if not loaded yet" do
      Woli::Config.expects(:load_config).returns(:fake_config)
      Woli.config.must_equal :fake_config
    end
  end

  describe ".diary" do
    before do
      module Woli
        @repository = :fake_repository
      end
    end

    after do
      module Woli
        @diary = nil
        @repository = nil
      end
    end

    it "returns a diary when already created" do
      module Woli
        @diary = :fake_diary
      end
      Woli.diary.must_equal :fake_diary
    end

    it "creates a diary if not created yet" do
      Woli::Diary.expects(:new).with(:fake_repository).returns(:fake_diary)
      Woli.diary.must_equal :fake_diary
    end
  end

  describe ".editor" do
    before do
      @old_env_editor = ENV['EDITOR']
      module Woli
        @config = { 'editor' => nil }
      end
    end

    after do
      module Woli
        @config = nil
      end
      ENV['EDITOR'] = @old_env_editor
    end

    it "returns an editor set in the config file if present" do
      module Woli
        @config = { 'editor' => 'strange_editor' }
      end
      Woli.editor.must_equal 'strange_editor'
    end

    it "returns an editor set via environment variable if not set via config file" do
      ENV['EDITOR'] = 'emacs'
      Woli.editor.must_equal 'emacs'
    end

    it "returns vim if no environment variable or config file sets the editor" do
      ENV['EDITOR'] = nil
      Woli.editor.must_equal 'vim'
    end
  end

  describe ".repository" do
    before do
      module Woli
        @config = {
          'repository_class' => 'Woli::FakeRepository',
          'repository_config' => :fake_config
        }

        class FakeRepository ; end
      end
    end

    after do
      module Woli
        @config = nil
        @repository = nil
      end
    end

    it "returns repository if already created" do
      module Woli
        @repository = :fake_repository
      end
      Woli.repository.must_equal :fake_repository
    end

    it "creates a new repository if not yet created" do
      Woli::FakeRepository.expects(:new).with(:fake_config).returns(:fake_repository)
      Woli.repository.must_equal :fake_repository
    end
  end
end
