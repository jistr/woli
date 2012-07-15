require_relative '../../spec_helper'
require 'woli/repositories/files'

describe Woli::Repositories::Files do
  before do
    @config = {
      'path' => '/tmp/fake_diary_path',
      'entry_extension' => 'md'
    }

    @repository = Woli::Repositories::Files.new(@config)

    @entry = stub(
      :date => Date.new(2012, 7, 6),
      :text => 'entry text',
      :repository => @repository
    )
    @entry_path = "#{@config['path']}/2012/07/2012-07-06.#{@config['entry_extension']}"
  end

  describe "#all_entries_dates" do
    before do
      Dir.stubs(:glob)
        .with("#{@config['path']}/**/*.#{@config['entry_extension']}")
        .returns([
          "#{@config['path']}/2012/07/2012-07-06.#{@config['entry_extension']}",
          "#{@config['path']}/2012/07/2012-07-04.#{@config['entry_extension']}",
          "#{@config['path']}/2012/07/2012-07-05.#{@config['entry_extension']}",
          "#{@config['path']}/2012/07/maliciously_named_file.#{@config['entry_extension']}",
          "#{@config['path']}/2012/07/2012-07-03-this-aint-right.#{@config['entry_extension']}"
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

  describe "#save_entry" do
    it "writes the text into a file" do
      File.expects(:write).with(@entry_path, @entry.text).returns(@entry.text.length)

      @repository.save_entry(@entry)
    end
  end

  describe "#delete_entry" do
    it "does nothing if the file does not exist" do
      File.expects(:exists?)
        .with(@entry_path)
        .returns(false)

      @repository.delete_entry(@entry).must_be_nil
    end

    it "deletes the file with entry contents" do
      File.expects(:exists?)
        .with(@entry_path)
        .returns(true)
      File.expects(:delete)
        .with(@entry_path)
        .returns(1)

      @repository.delete_entry(@entry)
    end
  end
end
