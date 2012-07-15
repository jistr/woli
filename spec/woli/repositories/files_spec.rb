require_relative '../../spec_helper'
require 'woli/repositories/files'

describe Woli::Repositories::Files do
  before do
    @repository_config = {
      'path' => '/tmp/fake_diary_path',
      'entry_extension' => 'md'
    }
    @repository = Woli::Repositories::Files.new(@repository_config)
  end

  describe "#all_entries_dates" do
    before do
      Dir.stubs(:glob)
        .with("#{@repository_config['path']}/**/*.#{@repository_config['entry_extension']}")
        .returns([
          '/tmp/fake_diary_path/2012/07/2012-07-06.md',
          '/tmp/fake_diary_path/2012/07/2012-07-04.md',
          '/tmp/fake_diary_path/2012/07/2012-07-05.md',
          '/tmp/fake_diary_path/2012/07/maliciously_named_file.md',
          '/tmp/fake_diary_path/2012/07/2012-07-03-this-aint-right.md'
        ])
    end

    it "returns correct and sorted dates for correctly named entry files, ignores others" do
      @repository.all_entries_dates.must_equal [
        Date.new(2012, 7, 4),
        Date.new(2012, 7, 5),
        Date.new(2012, 7, 6)
      ]
    end
  end
end
