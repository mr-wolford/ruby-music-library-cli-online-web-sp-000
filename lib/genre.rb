class Genre
  extend Concerns::Findable
  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
  end

  def save
    @@all << self
    self
  end

  def songs
    Song.all.select { |x| x.genre == self }
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    Genre.new(name).save
  end

  def artists
    songs.map { |x| x.artist }.uniq
  end



end
