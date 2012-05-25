module Woli
  class DiaryEntry
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def exists?
      File.exists?(@path)
    end

    def create_unless_exists
      unless exists?
        FileUtils.mkdir_p(File.dirname(@path))
        FileUtils.touch(@path)
      end
    end

    def date
      self.class.date_for_path(@path)
    end

    def self.for_day(date)
      self.new(self.path_for_date(date))
    end

    def self.path_for_date(date)
      File.join(
        Woli.diary_path,
        date.strftime('%Y'),
        date.strftime('%m'),
        date.strftime("%Y-%m-%d.#{Woli.config['diary_entry_extension']}")
      )
    end

    def self.date_for_path(path)
      basename = File.basename(path).gsub(/\.[^\.]*$/, '')
      year, month, day = basename.split('-').map { |string| string.to_i }
      DateTime.new(year, month, day)
    end
  end
end
