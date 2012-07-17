module Woli
  module Cli
    class Runner
      desc 'notify', 'Get notified when you forget to write entries.'
      def notify
        notify_config = Woli.config['notification']['missing_entries']

        if Woli.diary.missing_entries_count >= notify_config['days']
          `#{notify_config['command']}`
        end
      rescue ConfigError => e
        raise Thor::Error, e.message
      end
    end
  end
end
