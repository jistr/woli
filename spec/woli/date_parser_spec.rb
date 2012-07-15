require_relative '../spec_helper'
require 'woli/date_parser'

describe Woli::DateParser do
  before do
    @parser = Woli::DateParser
    @today = Date.new(2012, 7, 15)
    Timecop.freeze(@today)
  end

  after do
    Timecop.return
  end

  it "parses nil as today" do
    @parser.parse_date(nil).must_equal @today
  end

  it "parses 't' and 'today' as today" do
    @parser.parse_date('t').must_equal @today
    @parser.parse_date('today').must_equal @today
  end

  it "parses 'y' and 'yesterday' as yesterday" do
    @parser.parse_date('y').must_equal (@today - 1)
    @parser.parse_date('yesterday').must_equal (@today - 1)
  end

  it "parses '^2' as 2 days ago" do
    @parser.parse_date('^2').must_equal (@today - 2)
  end

  it "parses '^50' as 50 days ago" do
    @parser.parse_date('^50').must_equal (@today - 50)
  end

  it "parses '20' as 20th day of current month" do
    parsed = @parser.parse_date('20')
    parsed.year.must_equal @today.year
    parsed.month.must_equal @today.month
    parsed.day.must_equal 20
  end

  it "parses '20.2' as 20th February of current year" do
    parsed = @parser.parse_date('20.2')
    parsed.year.must_equal @today.year
    parsed.month.must_equal 2
    parsed.day.must_equal 20
  end

  it "parses '20/2/2011' as 20th February 2011" do
    parsed = @parser.parse_date('20/2/2011')
    parsed.year.must_equal 2011
    parsed.month.must_equal 2
    parsed.day.must_equal 20
  end

  it "parses '20.4', '20-4', '20/4', '20-4-2012' as the same dates (current year is 2012)" do
    date1 = @parser.parse_date('20.4')
    date2 = @parser.parse_date('20-4')
    date3 = @parser.parse_date('20/4')
    date4 = @parser.parse_date('20-4-2012')

    date1.must_equal date2
    date1.must_equal date3
    date1.must_equal date4
  end
end
