require 'date'

class Item
  attr_reader :genre, :label, :sourse, :author

  def initialize(publish_date)
    @id = Random.rand(1..1000)
    @publish_date = publish_date
    @archived = false
  end

  def can_be_archived?
    Date.today.year - Date.strptime(@publish_date, '%Y/%m/%d').year >= 10
  end

  def move_to_archive
    @archived = true unless can_be_archived?
  end

  def genre=(genre)
    @genre = genre
    genre.add_item(self) unless genre.items.include?(self)
  end
end
