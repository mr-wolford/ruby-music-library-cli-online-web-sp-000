require 'pry'

class Artist
  extend Concerns::Findable
  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
  end

  def save
    @@all << self
    @songs = []
    self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    Artist.new(name).save
  end

  def add_song(song)
    song.artist = self unless song.artist
  end

  def songs
    Song.all.select { |x| x.artist == self }
  end

  def genres
    songs.map { |x| x.genre }.uniq
  end



end
