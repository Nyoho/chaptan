# frozen_string_literal: true

require "mp3info"
require "yaml"

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

      if (options[:filename].nil?)
        puts "Usage: chaptan [-y yamlfile] mp3file"
        exit
      end

      mp3filename = options[:filename]
      ymlfilename = options[:yaml]
      if ymlfilename.nil?
        read_chapter(mp3filename)
      else
        chapters = load_yaml(ymlfilename)
        chapters.last["to"] = file_length(mp3filename)
        add_chapter(mp3filename, chapters)
      end
    end

    def file_length(filename)
      unless FileTest.exist?(filename)
        puts "Error: #{filename} does not exist."
        exit
      end
      Mp3Info.open(filename).length
    end

    def read_chapter(filename)
      unless FileTest.exist?(filename)
        puts "Error: #{filename} does not exist."
        exit
      end

      Mp3Info.open(filename) do |mp3info|
        puts mp3info
        puts "CTOC: #{mp3info.tag2.CTOC}"
        puts "TIT2: #{mp3info.tag2.TIT2}"
        puts "TPE1: #{mp3info.tag2.TPE1}"
        if mp3info.tag2.CHAP.nil?
          puts "There is no chapter information."
        else
          mp3info.tag2.CHAP.each do |chapter|
            puts "--------------------"
            puts chapter # .encode('utf-8', 'UTF-16')
          end
        end
      end
    end

    def add_chapter(filename, chapters)
      Mp3Info.open(filename) do |mp3info|
        unless mp3info.tag2.CHAP.nil?
          st = mp3info.tag2.CHAP[0]
          st[34] = "."
          mp3info.tag2.CHAP[0] = st
        end

        if chapters.size.positive?
          chaps = []
          ctoc = "toc1\x00".dup
          ctoc << [3, chapters.size].pack("CC")
          chapters.each_with_index do |ch, i|
            num = i + 1
            title = ch["title"]
            description = ch["description"]
            link = ch["link"]

            ctoc << "chp#{num}\x00"

            chap = "chp#{num}\x00".force_encoding("ASCII-8BIT").dup
            chap << [ch["start"] * 1000, ch["to"] * 1000].pack("NN").force_encoding("ASCII-8BIT")
            chap << "\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF".dup.force_encoding("ASCII-8BIT")

            title_tag = [title.encode("utf-16")].pack("a*")
            chap << "TIT2"
            chap << [title_tag.size + 1].pack("N")
            chap << "\x00\x00\x01"
            chap = chap.force_encoding("ASCII-8BIT")
            chap << title_tag

            unless description.nil?
              description_tag = [description.encode("utf-16")].pack("a*")
              chap << "TIT3"
              chap << [description_tag.size + 1].pack("N")
              chap << "\x00\x00\x01"
              chap << description_tag
            end

            unless link.nil?
              chap << "WXXX"
              chap << [link.length + 2].pack("N")
              chap << "\x00\x00\x00#{link}\00"
            end

            chaps << chap
          end
          mp3info.tag2.CTOC = ctoc
          mp3info.tag2.CHAP = chaps
        end
      end
    end

    def load_yaml(filename)
      yml = YAML.load_file(filename)
      (yml.length - 1).times.each do |i|
        yml[i]["to"] = yml[i + 1]["start"]
      end
      yml
    end
  end
end
