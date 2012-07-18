module Woli
  module Cli
    class Runner
      desc 'status', 'Print basic information about the diary.'
      def status
        entries_dates = Woli.diary.all_entries_dates
        date_format = '%d-%m-%Y'

        say "Woli Diary Status"
        say "================="

        if entries_dates.count > 0
          coverage = entries_dates.count / Float(entries_dates.last - entries_dates.first + 1)
          say "First entry: #{entries_dates.first.strftime(date_format)}"
          say "Last entry: #{entries_dates.last.strftime(date_format)}"
          say "Coverage: %2d %" % (coverage * 100).round
          say "Missing entries since the last one: #{Woli.diary.missing_entries_count}"
        else
          say "Diary is empty. Run 'woli help edit' to learn how to create entries."
        end
      rescue ConfigError => e
        raise Thor::Error, e.message
      end
    end
  end
end
