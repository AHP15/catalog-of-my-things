class Item
  def initialize(genre, author, source, label, publish_date)
    @id = Random.rand(1..1000)
    @genre = genre
    @author = author
    @source = source
    @label = label
    @publish_date = publish_date
    @archived = false
  end

  def can_be_archived?
    Date.today - @publish_date >= 10.years.ago.to_date
  end

  def move_to_archive
    @archived = true unless can_be_archived?
  end
end
