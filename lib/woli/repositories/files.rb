module Woli
  module Repositories
    class Files
      attr_reader :config

      def initialize(config)
        @config = config
      end

      def all_entries_dates
        all_entries_files.map { |filename|
          match_data = filename.match /(?<year>[0-9]{4})-(?<month>[0-9]{2})-(?<day>[0-9]{2}).#{Regexp.escape(config['entry_extension'])}\Z/
          Date.new(match_data[:year].to_i, match_data[:month].to_i, match_data[:day].to_i)
        }.sort
      end

      def load_entry(date)
        file_name = path_for_entry_date(date)
        return nil unless File.exists? file_name

        text = File.read(path_for_entry_date(date))
        DiaryEntry.new(date, text, self)
      end

      def save_entry(entry)
        File.write(path_for_entry_date(entry.date), entry.text)
      end

      def delete_entry(entry)
        file_name = path_for_entry_date(entry.date)
        return unless File.exists? file_name

        File.delete(file_name)
      end

      private

      def diary_path
        File.expand_path(config['path'])
      end

      def path_for_entry_date(date)
        File.join(
          diary_path,
          date.strftime('%Y'),
          date.strftime('%m'),
          date.strftime("%Y-%m-%d.#{config['entry_extension']}")
        )
      end

      def all_entries_files
        entry_like_filenames = Dir.glob(File.join(diary_path, '**', '*.' + config['entry_extension']))

        # Globbing is not enough -> filter the results further with regexps.
        entry_like_filenames.select do |filename|
          filename =~ %r{#{Regexp.escape(diary_path)}/[0-9]{4}/[0-9]{2}/[0-9]{4}-[0-9]{2}-[0-9]{2}.#{Regexp.escape(config['entry_extension'])}\Z}
        end
      end
    end
  end
end
