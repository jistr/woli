require_relative '../spec_helper'
require 'woli/diary'

describe Woli::Diary do
  before do
    @existing_entry = mock 'existing diary entry'
    @existing_entry_date = Date.new(2012, 7, 1)
    @nonexistent_entry_date = Date.new(2012, 7, 16)

    @repository = mock 'repository'
    @repository.stubs(:load_entry).with(@existing_entry_date).returns(@existing_entry)
    @repository.stubs(:load_entry).with(@nonexistent_entry_date).returns(nil)
    @repository.stubs(:all_entries_dates).returns([@existing_entry_date])

    @diary = Woli::Diary.new(@repository)
  end

  describe "#entry" do
    it "loads an existing entry" do
      @diary.entry(@existing_entry_date).must_equal @existing_entry
    end

    it "returns nil for a non-existent entry" do
      @diary.entry(@nonexistent_entry_date).must_equal nil
    end
  end

  describe "#load_or_create_entry" do
    before do
      @new_entry = :fake_new_entry
      class Woli::DiaryEntry ; end
      Woli::DiaryEntry.stubs(:new).with(@nonexistent_entry_date, '', @repository).returns(@new_entry)
    end

    it "loads an existing entry" do
      @diary.load_or_create_entry(@existing_entry_date).must_equal @existing_entry
    end

    it "creates a new entry for a non-existent entry" do
      @diary.load_or_create_entry(@nonexistent_entry_date).must_equal @new_entry
    end
  end

  describe "#all_entries_dates" do
    it "delegates the call to the repository" do
      @diary.all_entries_dates.must_equal @repository.all_entries_dates
    end
  end

  describe "#missing_entries_count" do
    it "returns an Integer" do
      Timecop.freeze(@repository.all_entries_dates.last + 1) do
        @diary.missing_entries_count.must_be_kind_of Integer
      end
    end

    it "returns 0 when the last entry is for today" do
      Timecop.freeze(@repository.all_entries_dates.last) do
        @diary.missing_entries_count.must_equal 0
      end
    end

    it "returns 1 when the last entry is for yesterday" do
      Timecop.freeze(@repository.all_entries_dates.last + 1) do
        @diary.missing_entries_count.must_equal 1
      end
    end

    it "returns 7 when the last entry is for a day week ago" do
      Timecop.freeze(@repository.all_entries_dates.last + 7) do
        @diary.missing_entries_count.must_equal 7
      end
    end
  end
end
