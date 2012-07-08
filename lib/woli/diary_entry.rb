module Woli
  class DiaryEntry
    attr_reader :repository, :date
    attr_accessor :text

    def initialize(date, text, repository)
      @date = date
      @text = text
      @repository = repository
    end

    def persist
      if text.strip.length > 0
        repository.save_entry(self)
      else
        puts "Empty entry -- removing."
        repository.delete_entry(self)
      end
    end
  end
end
