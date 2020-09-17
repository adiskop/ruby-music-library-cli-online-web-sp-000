require 'pry'
class Song
extend Concerns::Findable
  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist=(artist) if artist != nil
    self.genre=(genre) if genre != nil
    #self.genre=(genre)
    save
  end

  def artist
    @artist
  end

  def artist=(artist) #belongs to an artist
    @artist = artist
    artist.add_song(self)
    end

    def genre
      @genre
    end

    def genre=(genre)
      @genre = genre
      genre.songs << self unless genre.songs.include?(self)
      #adds the song to the genre's collection of songs (genre has many songs)
      #does not add the song to the genre's collection of songs if it already exists therein
    end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    Song.new(name, artist=nil, genre=nil)
  end

  def self.find_by_name(name)
    self.all.detect {|song| song.name == name}
  end

#returns (does not recreate) an existing song with the provided name if one exists in @@all
#creates a song if an existing match is not found
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end


############################################# use with MusicImporter
  def self.new_from_filename(filename)
song_data = filename.split(" - ")
    song = song_data[1]
    artist_name = song_data[0]
    genre_name = song_data[2].split(".mp3").join


    artist_name = Artist.find_or_create_by_name(artist_name)
    genre_name = Genre.find_or_create_by_name(genre_name)
    self.new(song, artist_name, genre_name)
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename)
    #self.create_from_filename(filename)
#Findable
  end



end
