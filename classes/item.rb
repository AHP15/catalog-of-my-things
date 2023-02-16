require 'date'

class Item
  attr_reader :genre, :label, :source, :author, :publish_date, :archived

  def initialize(publish_date)
    @id = Random.rand(1..1000)
    @publish_date = publish_date
    @archived = false
  end

  def move_to_archive
    @archived = true unless can_be_archived?
  end

  def genre=(genre)
    @genre = genre
    genre.add_item(self) unless genre.items.include?(self)
  end

  def label=(label)
    @label = label
    label.add_item(self) unless label.items.include?(self)
  end

  def author=(author)
    @author = author
    author.add_item(self) unless author.items.include?(self)
  end

  private

  def can_be_archived?
    Date.today.year - Date.strptime(@publish_date, '%Y/%m/%d').year >= 10
  end
end
