require 'spec_helper'
require 'woli/cli/runner'

describe Woli::Cli::Runner do
  before do
    @diary = mock 'diary'
    Woli.stubs(:diary).returns(@diary)
    @runner = Woli::Cli::Runner.new
  end

  describe "list task" do
    it "prints dates for all diary entries" do
      @diary.expects(:all_entries_dates).returns([
        Date.new(2012, 7, 4),
        Date.new(2012, 7, 5),
        Date.new(2012, 7, 6)
      ])
      expected_output = [
        '04-07-2012',
        '05-07-2012',
        '06-07-2012'
      ]
      @runner.expects(:say).times(3).with do |output|
        output == expected_output.shift
      end
      @runner.list
    end

    it "doesn't print anything if the diary is empty" do
      @diary.expects(:all_entries_dates).returns([])
      @runner.expects(:say).never
      @runner.list
    end
  end
end
