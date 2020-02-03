# frozen_string_literal: true

module MP3Librarian
  module Services
    class MP3Search
      def search
        puts 'Podaj wyszukiwaną frazę:'
        result = get_result
        if result.empty?
          puts 'Nie znaleziono'
        else
          result.each(&method(:puts))
        end
      end

      private

      def get_result
        query = gets.chomp
        MP3Librarian::Clients::DbClient.new.search(query)
      end
    end
  end
end
