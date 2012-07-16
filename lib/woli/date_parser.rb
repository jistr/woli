module Woli
  module DateParser
    def self.parse_date_long_desc
      <<-END
        Specifying DAY:

        1) Implicitly: If no date is given, 'today' is assumed.

        2) Via a keyword: woli edit DAYNAME
        (Where DAYNAME can be:
        'today' or 't';
        'yesterday' or 'y')

        3) Via a date: woli edit DD[-MM[-YYYY]]
        (Use hyphens, dots or slashes to separate day/month/year.
        If year or month is not given, current year / current month is assumed.)

        4) Via days ago: woli edit ^DAYS
        (Where DAYS is a number of days ago. ^1 is yesterday, ^7 is a week ago etc.)
      END
    end

    def self.parse_date(fuzzy_date)
      case fuzzy_date
      when 'today', 't'
        Date.today
      when 'yesterday', 'y'
        Date.today - 1
      when /\A\^(?<days_ago>\d+)/
        Date.today - Integer($~[:days_ago])
      when /\A(?<day>\d+)([-\.\/](?<month>\d+)([-\.\/](?<year>\d+))?)?\Z/
        today = Date.today
        year = $~[:year] ? Integer($~[:year]) : today.year
        month = $~[:month] ? Integer($~[:month]) : today.month
        day = $~[:day] ? Integer($~[:day]) : today.day
        Date.new(year, month, day)
      else
        raise Thor::MalformattedArgumentError, "'#{fuzzy_date}' is not a valid way to specify a date."
      end
    end
  end
end
