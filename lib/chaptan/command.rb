require 'mp3info'

module Chaptan

  class Command

    def self.run(argv)
      new(argv).execute
    end

    def initialize(argv)
      @argv = argv
    end
    
    def execute
      puts "Hello."
    end

  end
  
end
