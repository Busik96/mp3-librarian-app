# frozen_string_literal: true

require 'id3tag'

module MP3Librarian
  module Services
    class FileScanner
      def initialize(file)
        @file = file
      end

      def details
        result = {}
        ID3Tag.read(File.open(@file, 'rb')) do |tag|
          result[:path] = @file
          result[:artist] = tag.artist
          result[:title] = tag.title
          result[:album] = tag.album
          result[:year] = tag.year
          result[:track_nr] = tag.track_nr
          result[:genre] = tag.genre
        end

        result
      end
    end
  end
end
