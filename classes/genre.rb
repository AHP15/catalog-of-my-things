class Genre
  attr_reader :items, :name

  def initialize(name)
    @id = Random.rand(1..1000)
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.genre = self
  end

  def to_hash
    {
      'id' => @id,
      'name' => @name,
      'class' => self.class.name
    }
  end
end
