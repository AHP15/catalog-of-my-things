require_relative './item'

class MusicAlbum < Item
  def initialize(publish_date, on_spotify)
    @on_spotify = on_spotify
    super(publish_date)
  end

  def can_be_archived?
    super() && @on_spotify
  end

  def to_hash
    {
      'id' => @id,
      'on_spotify' => @on_spotify,
      'publish_date' => @publish_date,
      'genre' => @genre&.to_hash,
      'label' => @label&.to_hash,
      'sourse' => @sourse&.to_hash,
      'author' => @author&.to_hash
    }
  end
end
