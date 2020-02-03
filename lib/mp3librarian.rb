# frozen_string_literal: true

require_relative 'mp3librarian/services/file_scanner'
require_relative 'mp3librarian/services/folder_scanner'
require_relative 'mp3librarian/clients/db_client'
require_relative 'mp3librarian/services/mp3_search'
require 'pry'

module MP3Librarian
  class Application
    def self.run!(*args)
      arg = args.first&.dup
      ARGV.clear
      self.new(arg.first)
    end

    def initialize(folder)
      @folder = folder
      show_menu
    end

    private

    def show_menu
      @menu = ['1.Skanuj katalog', '2.Wyszukaj mp3']

      puts 'Witaj w MP3Librarian!'
      @menu.each { |el| puts el }
      czekaj_na_decyzje
    end

    def czekaj_na_decyzje
      opcja = gets.strip.chomp
      if opcja == '1'
        system('clear')
        Services::FolderScanner.new(@folder).scan
        show_menu
      elsif opcja == '2'
        system('clear')
        Services::MP3Search.new.search
        show_menu
      else
        puts 'Wpisano zły numer'
      end
    end

  end
end
