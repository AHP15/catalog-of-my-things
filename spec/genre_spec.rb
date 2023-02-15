require_relative './helper_spec'

describe Genre do
  before :all do
    @genre = Genre.new('test genre')
  end

  it 'should initialize instance' do
    expect(@genre).to be_an_instance_of(Genre)
  end

  it 'should add item' do
    # Arrange
    item = Item.new('2023/02/14')
    prev_length = @genre.items.length

    # Act
    @genre.add_item(item)

    # Assertion
    expect(@genre.items.length).to eq(prev_length + 1)
  end

  it 'should return a hash' do
    # Act
    hash = @genre.to_hash

    # Assertions
    expect(hash.key?('id')).to eq(true)
    expect(hash.key?('name')).to eq(true)
    expect(hash.key?('items')).to eq(true)
  end
end
