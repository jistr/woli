module Woli
  class Diary
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def missing_entries_count
      return 0 unless last_entry
      (last_entry.date - DateTime.now.to_date).to_i
    end

    def last_entry
      year_dir = File.join(@path, Dir.entries(@path).sort.last)
      return unless year_dir

      month_dir = File.join(year_dir, Dir.entries(year_dir).sort.last)
      return unless month_dir

      entry_file = File.join(
        month_dir,
        Dir.entries(month_dir).sort { |a, b| path_sorter_dirs_first(a, b) }.last
      )
      return unless entry_file

      DiaryEntry.new(entry_file)
    end

    private

    def path_sorter_dirs_first(a, b)
      a_is_dir = File.directory?(a)
      b_is_dir = File.directory?(b)

      if a_is_dir && !b_is_dir
        -1
      elsif !a_is_dir && b_is_dir
        1
      else
        a <=> b
      end
    end
  end
end
