require 'pry'

class Song
  extend Concerns::Findable
  attr_accessor :name, :genre
  attr_reader :artist

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) if artist
    self.genre = genre if genre
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def save
    @@all << self
    self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    Song.new(name).save
  end

  def self.new_from_filename(filename)
    artist, song, genre = filename.split(" - ")
    genre.slice!(".mp3")
    new_artist = Artist.find_or_create_by_name(artist)
    new_genre = Genre.find_or_create_by_name(genre)
    Song.new(song, new_artist, new_genre)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end



end
