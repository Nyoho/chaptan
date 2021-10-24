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

      mp3filename = options[:filename]
      ymlfilename = options[:yaml]
      if ymlfilename.nil?
        read_chapter(mp3filename)
      else
        p [mp3filename, ymlfilename]
        add_chapter(mp3filename, {})
      end
    end

    def add_chapter(filename, info_dict)
      chapters = [
        {title: "はじめに", description: "Some description for Chapter 1", start: 0, to: 1},
        {title: "聖闘士星矢", link: "https://www.google.com/search?rls=en&q=%E8%81%96%E9%97%98%E5%A3%AB%E6%98%9F%E7%9F%A2&ie=UTF-8&oe=UTF-8", start: 1, to: 2},
        {title: "FGOについて", start: 2, to: 3},
      ]

      # current info
      Mp3Info.open(filename) do |mp3info|
        puts mp3info
        puts mp3info.tag2.CTOC
        puts mp3info.tag2.TIT2
        if mp3info.tag2.CHAP.nil?
          puts "There is no chapter information."
        else
          mp3info.tag2.CHAP.each do |chapter|
            puts '--------------------'
            puts chapter#.encode('utf-8', 'UTF-16')
          end
          mp3info.tag2.CTOC #String
          mp3info.tag2.TPE1
          st = mp3info.tag2.CHAP[0]
          st[34] = "."
          mp3info.tag2.CHAP[0] = st
        end

        if (chapters.size > 0) then
          chaps = []
          ctoc = "toc1\x00".dup
          ctoc << [3, chapters.size].pack("CC")
          chapters.each_with_index do |ch, i|
            num = i+1
            title = ch[:title]
            description = ch[:description]
            link = ch[:link]
            
            ctoc << "chp#{num}\x00"

            chap = "chp#{num}\x00".force_encoding('ASCII-8BIT').dup
            chap << [ch[:start]*1000, ch[:to]*1000].pack("NN").force_encoding('ASCII-8BIT')
            chap << "\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF".dup.force_encoding('ASCII-8BIT')
            
            title_tag = [title.encode("utf-16")].pack("a*")
            chap << "TIT2"
            chap << [title_tag.size+1].pack("N")
            chap << "\x00\x00\x01"
            chap = chap.force_encoding('ASCII-8BIT')
            chap << title_tag
            
            if !description.nil? then
      	      description_tag = [description.encode("utf-16")].pack("a*")
              chap << "TIT3"
              chap << [description_tag.size+1].pack("N")
              chap << "\x00\x00\x01"
              chap << description_tag
            end
            
            if !link.nil? then
              chap << "WXXX"
              chap << [link.length+2].pack("N")
              chap << "\x00\x00\x00#{link}\00"
            end
            
            chaps << chap
          end
          mp3info.tag2.CTOC = ctoc
          mp3info.tag2.CHAP = chaps
        end
      end

      # CTOC に "toc"
      #         child_element_ids=[u"chp1", "chp2"],
      # CHAP を chapter の個数作ってその中に
      # chp1, start_time=0, to_time=40000 (たぶんmsec)
      # TIT2 に "聖闘士星矢 - I'm the first chapter"
    end
  end
end
