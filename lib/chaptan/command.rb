# frozen_string_literal: true

require "mp3info"

module Chaptan
  # A command class for Chaptan
  class Command
    def self.run(argv)
      new(argv).execute
    end

    def initialize(argv)
      @argv = argv
    end

    def execute
      options = Options.parse!(@argv)

      p options
    end
  end
end
