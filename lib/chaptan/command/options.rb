# frozen_string_literal: true

require "optparse"

module Chaptan
  class Command
    # Command line options
    module Options
      def self.parse!(argv)
        command_parser = OptionParser.new do |opt|
          opt.on_head('-v', '--version', "Show version") do |v|
            opt.version = Chaptan::VERSION
            puts opt.ver
            exit
          end
        end

        command_parser.parse!(argv)
      end
    end
  end
end
