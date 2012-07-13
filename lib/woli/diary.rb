module Woli
  class Diary
    attr_reader :repository

    def initialize(repository)
      @repository = repository
    end

    def all_entries_dates
      @repository.all_entries_dates
    end

    def missing_entries_count
      last_entry_date = @repository.all_entries_dates.last
      return 0 unless last_entry_date
      (DateTime.now.to_date - last_entry_date).to_i
    end
  end
end
