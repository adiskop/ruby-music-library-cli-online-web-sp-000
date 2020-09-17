class Artist
  extend Concerns::Findable

  attr_accessor :name, :songs, :genre

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    save
  end

  def add_song(song)
    if song.artist == nil
      song.artist = self
    else
      nil
    end
    unless @songs.include?(song)
    @songs << song
    end
    song
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
    Artist.new(name)
  end

  def songs
    @songs
  end

  def genres
    genre_array = @songs.collect {|song| song.genre}
    genre_array.uniq
  end
end
