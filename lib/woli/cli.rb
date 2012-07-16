require 'woli'
require 'woli/date_parser'
require 'thor'

module Woli
  class Cli < Thor
  end
end

require 'woli/cli/edit'
require 'woli/cli/init'
require 'woli/cli/list'
require 'woli/cli/notify'
require 'woli/cli/status'
