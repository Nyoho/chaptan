# frozen_string_literal: true

require "optparse"

module Chaptan
  class Command
    # Command line options
    module Options
      def self.parse!(argv)
        options = {}
        opt = OptionParser.new

        opt.on_head("-v", "--version", "Show version") do |_v|
          opt.version = Chaptan::VERSION
          puts opt.ver
          exit
        end

        opt.on_head("-y", "--yaml [filename]", "yaml file of data of chapters") do |v|
          options[:yaml] = v
        end
        opt.parse!(argv)

        options[:filename] = argv[0]

        options
      end
    end
  end
end
