module Woli
  class Cli
    desc 'edit DAY', 'Edit a diary entry for a given day.'
    long_desc <<-END
      Edit a diary entry for a given day.

      Specifying DAY:

      1) Via date: woli edit DD[-MM[-YYYY]]
      Use hyphens, dots or slashes to separate day/month/year.
      If year or month is not given, current year (current month) is assumed.

      2) Via keywords: woli edit [today|yesterday]

      3) Implicitly: If no date is given, 'today' is assumed.
    END
    def edit(fuzzy_day = 'today')
      @entry = DiaryEntry.for_day(parse_day(fuzzy_day))
      @entry.create_unless_exists
      tty = `tty`.strip
      `#{Woli.editor} < #{tty} > #{tty} #{@entry.path}`
    end

    private

    def parse_day(fuzzy_day)
      # FIXME really perform parsing
      return DateTime.now
    end
  end
end
