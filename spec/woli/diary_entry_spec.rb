require_relative '../spec_helper'
require 'woli/diary_entry'

describe Woli::DiaryEntry do
  before do
    @repository = mock 'repository'
  end

  describe "empty entry" do
    before do
      @entry = Woli::DiaryEntry.new(Date.new(2012, 7, 14), '', @repository)
    end

    it "removes itself from the repository when persisting its state" do
      @repository.expects(:delete_entry).with(@entry)
      @entry.persist
    end
  end

  describe "pseudoempty entry (whitespace only)" do
    before do
      @entry = Woli::DiaryEntry.new(Date.new(2012, 7, 14), "\n\n  \n", @repository)
    end

    it "removes itself from the repository when persisting its state" do
      @repository.expects(:delete_entry).with(@entry)
      @entry.persist
    end
  end

  describe "filled in entry" do
    before do
      text = <<-END
        * Today I had the best ice cream.

        * I slipped on a banana and didn't break anything. Yay!
      END
      @entry = Woli::DiaryEntry.new(Date.new(2012, 7, 14), text, @repository)
    end

    it "saves itself into the repository when persisting its state" do
      @repository.expects(:save_entry).with(@entry)
      @entry.persist
    end
  end
end

