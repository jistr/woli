module Woli
  class Cli
    desc 'notify', 'Get notified when you forget to write entries.'
    def notify
      notify_config = Woli.config['notification']['missing_entries']

      if Woli.diary.missing_entries_count > notify_config['days']
        `#{notify_config['command']}`
      end
    end
  end
end
