
class Artist
attr_accessor :name
attr_reader :songs

extend Concerns::Findable

@@all=[]

def initialize(name)
@name=name
save
@songs=[]
end

def self.all
@@all
end

def self.destroy_all
@@all.clear
end

def save
@@all<<self
end

def self.create(name)
newArtist=self.new(name)

end

def add_song(song)
  song.artist =self unless song.artist
  @songs<<song unless songs.include?(song)
end

def genres
    songs.collect(&:genre).uniq
  end


end





#learn spec/004_songs_and_artists_spec.rb
#learn spec/005_songs_and_genres_spec.rb
#learn spec/006_artists_and_genres_spec.rb
