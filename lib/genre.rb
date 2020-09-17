
class Genre
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    save
  end

  def genre=
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
    Genre.new(name)
  end

#collects artists through its songs instead of maintaining its own @artists instance
#variable (genre has many artists through songs)
    def artists
      artist_array = @songs.collect {|song| song.artist}
      artist_array.uniq
    end

end
