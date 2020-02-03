# frozen_string_literal: true

require 'tty-progressbar'


module MP3Librarian
  module Services
    class FolderScanner
      def initialize(folder)
        @folder = folder
      end

      def scan
        return NotExistingFolderError unless File.directory?(@folder)
        return EmptyFolderError if Dir.empty?(@folder)

        files = Dir.glob(search_path)
        bar = TTY::ProgressBar.new('Indeksuje [:bar]', total: files.size)
        files.each do |file|
          song_details = FileScanner.new(file).details
          db_client.insert_file(song_details)
          bar.advance(1)
        end

        puts 'Zakończono indeksowanie!'
      end

      private

      def search_path
        File.join(@folder, '/**/*.mp3')
      end

      def db_client
        @db_client ||= MP3Librarian::Clients::DbClient.new
      end
    end
  end
end
