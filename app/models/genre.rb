class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :artists, through: :songs
  has_many :songs, through: :song_genres

  def slug
    name.downcase.gsub!(/\s/,'-')
  end

  def self.find_by_slug(slug)
    self.all.find{|genre| genre.slug == slug}
  end

end
