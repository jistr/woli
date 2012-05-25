require 'woli'
require 'thor'

module Woli
  class Cli < Thor
  end
end

require 'woli/cli/edit'
require 'woli/cli/notify'
require 'woli/cli/status'
