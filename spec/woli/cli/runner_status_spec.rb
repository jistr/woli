require_relative '../../spec_helper'
require 'woli/cli/runner'

describe Woli::Cli::Runner do
  before do
    @diary = mock 'diary'
    @diary.stubs(:all_entries_dates).returns([
      Date.new(2012, 7, 4),
      Date.new(2012, 7, 6),
      Date.new(2012, 7, 7)
    ])
    @diary.stubs(:missing_entries_count).returns(2)
    Woli.stubs(:diary).returns(@diary)

    @runner = Woli::Cli::Runner.new

    @output = ''
    @runner.stubs(:say).with do |to_print|
      @output << to_print << "\n"
    end
  end

  it "prints first and last entry dates" do
    @runner.status
    @output.must_match /first entry: 04-07-2012/i
    @output.must_match /last entry: 07-07-2012/i
  end

  it "prints entry/day coverage" do
    @runner.status
    @output.must_match /coverage: 75 %/i
  end

  it "prints the number of missing entries since the last one" do
    @runner.status
    @output.must_match /missing entries[^:]*: 2/i
  end

  it "informs of empty diary" do
    @diary.stubs(:all_entries_dates).returns([])
    @runner.status
    @output.must_match /diary is empty/i
  end
end
