module Woli
  module Cli
    class Runner
      desc 'edit DAY', 'Edit a diary entry for a given day.'
      long_desc <<-END
        Edit a diary entry for a given day.

        #{DateParser.parse_date_long_desc}
      END
      def edit(fuzzy_date = 'today')
        date = DateParser.parse_date(fuzzy_date)
        entry = Woli.diary.load_or_create_entry(date)

        temp_file_name = generate_temp_file_name(entry)
        save_text_to_temp_file(entry, temp_file_name)
        edit_file_in_editor(temp_file_name)
        load_text_from_temp_file(entry, temp_file_name)

        entry.persist
      rescue ConfigError => e
        raise Thor::Error, e.message
      end

      private

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
end
