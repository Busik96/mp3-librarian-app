# frozen_string_literal: true

require 'sqlite3'

module MP3Librarian
  module Clients
    class DbClient
      DB_PATH = 'data.db'
      INSERT_SQL = <<-SQL
        INSERT INTO songs
        (path, artist, title, album, year, track_nr, genre)
        VALUES (?, ?, ?, ?, ?, ?, ?);
      SQL
      UPDATE_SQL = <<-SQL
        UPDATE songs
        SET path = ?,title = ?, artist = ?, album = ?, year = ?, track_nr = ?, genre = ?
        WHERE path = ?;
      SQL
      SEARCH_SQL = <<-SQL
        SELECT path
        FROM songs
        WHERE
        path LIKE ? OR
        artist LIKE ? OR
        title LIKE ? OR
        album LIKE ? OR
        year = ? OR
        genre LIKE ?;
      SQL

      def initialize
        setup_db unless File.exist?(DB_PATH)
      end

      def insert_file(file_details)
        if song_exist?(file_details[:path])
          update_song(file_details)
        else
          insert_song(file_details)
        end
      end

      def search(query)
        db.execute(
          SEARCH_SQL,
          ["%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", query, "%#{query}%"]
        ).flatten
      end

      def db
        @db ||= SQLite3::Database.new(DB_PATH)
      end

      private

      def update_song(file_details)
        db.execute(
          UPDATE_SQL,
          [file_details[:path]] + file_details.values
        )
      end

      def insert_song(file_details)
        db.execute(
          INSERT_SQL,
          file_details.values
        )
      end

      def song_exist?(file_path)
        !db.execute('SELECT path FROM songs WHERE path = ?', file_path).empty?
      end

      def setup_db
        db.execute(
          <<-SQL
            CREATE TABLE songs (
              path varchar(255),
              artist varchar(255),
              title varchar(255),
              album varchar(255),
              year varchar(255),
              track_nr varchar(255),
              genre varchar(255)
            );
          SQL
        )
      end
    end
  end
end
