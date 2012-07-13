module Woli
  class Cli
    desc 'status', 'Print basic information about the diary.'
    def status
      all_entries_dates = Woli.diary.all_entries_dates
      date_format = '%d-%m-%Y'
      coverage = all_entries_dates.count / Float(all_entries_dates.last - all_entries_dates.first)

      puts "Woli Diary Status"
      puts "================="
      puts "First entry: #{all_entries_dates.first.strftime(date_format)}"
      puts "Last entry: #{all_entries_dates.last.strftime(date_format)}"
      puts "Coverage: %2d %" % (coverage * 100).round
      puts "Missing entries since the last one: #{Woli.diary.missing_entries_count}"
    end
  end
end
