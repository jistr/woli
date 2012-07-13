module Woli
  class Cli
    desc 'edit DAY', 'Edit a diary entry for a given day.'
    long_desc <<-END
      Edit a diary entry for a given day.

      Specifying DAY:

      1) Implicitly: If no date is given, 'today' is assumed.

      2) Via keywords: woli edit [today|yesterday]

      3) Via date: woli edit DD[-MM[-YYYY]]
      Use hyphens, dots or slashes to separate day/month/year.
      If year or month is not given, current year (current month) is assumed.
    END
      # 4) Via days ago: woli edit ^DAYS
      # Where DAYS is a number of days ago (^1 is yesterday, ^7 is a week ago etc.)
    def edit(fuzzy_date = 'today')
      date = parse_date(fuzzy_date)
      entry = Woli.repository.load_entry(date) || DiaryEntry.new(date, '', Woli.repository)

      temp_file_name = generate_temp_file_name(entry)
      save_text_to_temp_file(entry, temp_file_name)
      edit_file_in_editor(temp_file_name)
      load_text_from_temp_file(entry, temp_file_name)

      entry.persist
    end

    private

    def parse_date(fuzzy_date)
      # FIXME really perform parsing
      return DateTime.now
    end

    def save_text_to_temp_file(entry, temp_file_name)
      File.write(temp_file_name, entry.text)
    end

    def load_text_from_temp_file(entry, temp_file_name)
      entry.text = File.read(temp_file_name)
      File.delete(temp_file_name)
    end

    def generate_temp_file_name(entry)
      "/tmp/woli_edit_entry_#{entry.date.strftime('%Y_%m_%d')}.#{Woli.config['edit_entry_extension']}"
    end

    def edit_file_in_editor(file_name)
      tty = `tty`.strip
      `#{Woli.editor} < #{tty} > #{tty} #{file_name}`
    end
  end
end
