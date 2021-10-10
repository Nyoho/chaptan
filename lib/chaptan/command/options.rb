# frozen_string_literal: true

require "optparse"

module Chaptan
  class Command
    # Command line options
    module Opitons
      def self.parse!(_argv)
        {}
      end
    end
  end
end
