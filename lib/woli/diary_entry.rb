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

    def self.for_day(date)
      self.new(self.path_for_date(date))
    end

    private

    def self.path_for_date(date)
      File.join(
        Woli.diary_path,
        date.strftime('%Y'),
        date.strftime('%m'),
        date.strftime("%Y-%m-%d.#{Woli.config['diary_entry_extension']}")
      )
    end
  end
end
