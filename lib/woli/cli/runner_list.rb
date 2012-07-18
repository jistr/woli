module Woli
  module Cli
    class Runner
      desc 'list', 'List dates for which there are entries in the diary.'
      def list
        Woli.diary.all_entries_dates.each do |date|
          say date.strftime('%d-%m-%Y')
        end
      rescue ConfigError => e
        raise Thor::Error, e.message
      end
    end
  end
end
