class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, :through => :song_genres

  def slug
    self.name.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    self.all.each do |object|
      @song = object.name if object.slug == slug
    end
    self.find_by(:name => @song)
  end

end
