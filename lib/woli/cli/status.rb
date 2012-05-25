module Woli
  class Cli
    desc 'status', 'Print basic information about the diary.'
    def status
      puts "Woli Diary Status"
      puts "================="
      puts "Missing entries since the last entry: #{Woli.diary.missing_entries_count}"
      puts "Diary located at: #{Woli.diary.path}"
    end
  end
end
