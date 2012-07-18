require_relative '../../spec_helper'
require 'woli/cli/runner'

describe Woli::Cli::Runner do
  before do
    module Woli::Config ; end
    @runner = Woli::Cli::Runner.new
  end
  describe "init task" do
    it "creates configuration for the user and informs them" do
      Woli::Config.expects(:create_config_file_from_template).returns('/home/woli/.woli/config.yml')
      @runner.expects(:say).with { |text| text =~ %r{created at /home/woli/\.woli/config\.yml} }
      @runner.init
    end

    it "informs the user if the config file is already present" do
      Woli::Config.expects(:create_config_file_from_template).returns(nil)
      @runner.expects(:say).with { |text| text =~ %r{already exists} }
      @runner.init
    end
  end
end
