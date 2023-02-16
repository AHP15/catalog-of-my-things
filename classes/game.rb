require_relative './item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at, :publish_date

  def initialize(multiplayer, last_played_at, publish_date)
    super(publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def to_json(*_args)
    {
      'multiplayer' => @multiplayer,
      'last_played_at' => @last_played_at,
      'publish_date' => @publish_date,
      'class' => self.class.name
    }
  end

  private

  def can_be_archived?
    super && (last_played_at < (Time.now - (2 * 365 * 24 * 60 * 60)).to_s)
  end
end
