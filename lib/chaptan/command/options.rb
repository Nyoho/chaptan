# frozen_string_literal: true

require "optparse"

module Chaptan
  class Command
    # Command line options
    module Options
      def self.parse!(_argv)
        {}
      end
    end
  end
end
