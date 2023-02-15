require_relative '../classes/label'

describe Label do
  let(:title) { 'Test label' }
  let(:color) { 'blue' }
  let(:label) { Label.new(title, color) }

  describe '#initialize' do
    it 'should set the title and color' do
      expect(label.title).to eq(title)
      expect(label.color).to eq(color)
    end

    it 'should set the id to a random number between 1 and 1000' do
      expect(label.instance_variable_get(:@id)).to be_between(1, 1000)
    end

    it 'should initialize an empty array for items' do
      expect(label.items).to be_empty
    end
  end

  describe '#add_item' do
    let(:item) { double('item') }

    it 'should set the label for the item' do
      expect(item).to receive(:label).with(label)
      label.add_item(item)
    end
  end

  describe '#to_json' do
    it 'should return a JSON representation of the label' do
      expected_output = {
        'id' => label.instance_variable_get(:@id),
        'title' => title,
        'color' => color,
        'class' => 'Label'
      }
      expect(label.to_json).to eq(expected_output)
    end
  end
end
