module Woli
  class Cli
    desc 'status', 'Print basic information about the diary.'
    def status
      entries_dates = Woli.diary.all_entries_dates
      date_format = '%d-%m-%Y'
      coverage = entries_dates.count / Float(entries_dates.last - entries_dates.first + 1)

      puts "Woli Diary Status"
      puts "================="
      puts "First entry: #{entries_dates.first.strftime(date_format)}"
      puts "Last entry: #{entries_dates.last.strftime(date_format)}"
      puts "Coverage: %2d %" % (coverage * 100).round
      puts "Missing entries since the last one: #{Woli.diary.missing_entries_count}"
    rescue ConfigError => e
      raise Thor::Error, e.message
    end
  end
end
