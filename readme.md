# Załozenia

Aplikacja która kataloguje pliki MP3

Podajesz programowi dowolną ściezke na dysku.

Program ma 2 funkcje:
* Skanuj katalog - przeszukuje podana sciezke i skanuje znalezione pliki MP3,
katalogujac informacje w podrecznej bazie danych
* Wyszukaj MP3 - pozwala znalezc odpowiedni plik na podstawie dowolnego pola w opisie MP3

Załozenia techniczne:
- uzywamy bazy sqlite
- programik odpalany z poziomu konsoli
- dobrze przemyslana struktura plikow
- skanujemy mp3 tagi
- na plus: obsluga progress bara, przy skanowaniu plików

Przydatne gemy:
- https://github.com/krists/id3tag
- https://github.com/sparklemotion/sqlite3-ruby
- https://github.com/piotrmurach/tty-progressbar
