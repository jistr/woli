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
end
