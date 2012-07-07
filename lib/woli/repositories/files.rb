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
      end

      def save_entry(entry)
      end

      private

      def diary_dir
        File.expand_path(config['path'])
      end

      def all_entries_files
        entry_like_filenames = Dir.glob(File.join(diary_dir, '**', '*.' + config['entry_extension']))

        # Globbing is not enough -> filter the results further with regexps.
        entry_like_filenames.select do |filename|
          filename =~ %r{#{Regexp.escape(diary_dir)}/[0-9]{4}/[0-9]{2}/[0-9]{4}-[0-9]{2}-[0-9]{2}.#{Regexp.escape(config['entry_extension'])}\Z}
        end
      end
    end
  end
end
