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
end
