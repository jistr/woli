require 'woli'
require 'woli/cli/date_parser'
require 'thor'

module Woli
  module Cli
    class Runner < Thor
    end
  end
end

require 'woli/cli/runner_edit'
require 'woli/cli/runner_init'
require 'woli/cli/runner_list'
require 'woli/cli/runner_notify'
require 'woli/cli/runner_status'
