require_relative '../classes/author'

describe Author do
  let(:first_name) { 'first_name' }
  let(:last_name) { 'last_name' }
  let(:author) { Author.new(first_name, last_name) }

  describe '#initialize' do
    it 'should set the first and last name' do
      expect(author.first_name).to eq(first_name)
      expect(author.last_name).to eq(last_name)
    end

    it 'should set the id to a random number between 1 and 1000' do
      expect(author.instance_variable_get(:@id)).to be_between(1, 1000)
    end

    it 'should initialize an empty array for items' do
      expect(author.items).to be_empty
    end
  end

  describe '#add_item' do
    let(:item) { double('item') }

    it 'should set the author for the item' do
      expect(item).to receive(:author).with(author)
      author.add_item(item)
    end
  end

  describe '#to_json' do
    it 'should return a JSON representation of the author' do
      expected_output = {
        'id' => author.instance_variable_get(:@id),
        'first_name' => first_name,
        'last_name' => last_name,
        'class' => 'Author'
      }
      expect(author.to_json).to eq(expected_output)
    end
  end
end
