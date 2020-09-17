require 'pry'
class MusicLibraryController
  attr_accessor :path

  def initialize(path="./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end

  def call
    input = "" #no user input but asks again
    while input != "exit"
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    input = gets.strip

      case input
        when "list songs"
        list_songs
        when "list artists"
        list_artists
        when "list genres"
        list_genres
        when "list artist"
        list_songs_by_artist
        when "list genre"
        list_songs_by_genre
        when "play song"
        play_song

      end
    end
  end

  def list_songs
    song_list = []
    song_list = Song.all.sort {|a, b| a.name <=> b.name} #alphabetize
    song_list.each_with_index {|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"} #print as a numbered list
  end

  def list_artists
    artist_list = []
    artist_list = Artist.all.sort {|a, b| a.name <=> b.name}
    artist_list.each_with_index {|artist, index| puts "#{index+1}. #{artist.name}"}
    #artist_list.each_with_index {|artist, index|
  end

  def list_genres
    genre_list = []
    genre_list = Genre.all.sort {|a, b| a.name <=> b.name}
    genre_list.each_with_index {|genre, index| puts "#{index+1}. #{genre.name}"}
  end

  def list_songs_by_artist
    input = puts "Please enter the name of an artist:"
    input = gets.strip
      if artist = Artist.find_by_name(input)
        artist.songs.sort {|a, b| a.name <=> b.name}.each_with_index {|song, index| puts "#{index+1}. #{song.name} - #{song.genre.name}"}

      end
  end

  def list_songs_by_genre
    input = puts "Please enter the name of a genre:"
    input = gets.strip
      if genre = Genre.find_by_name(input)#prints all songs by a particular genre
        genre.songs.sort {|a, b| a.name <=> b.name}.each_with_index {|song, index| puts "#{index}. #{song.artist.name} - #{song.name}"}
        #in a numbered list
        #alphabetized by song name
      end
  end

  def play_song
    input = puts "Which song number would you like to play?"
    input = gets.strip.to_i
     if input > 0 && input <= Song.all.length #valid input
       song = Song.all.sort {|a, b| a.name <=> b.name}
       play_song = song[input-1]
      puts "Playing #{play_song.name} by #{play_song.artist.name}"
    end
  end

end
