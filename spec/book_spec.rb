require_relative '../classes/book'

describe Book do
  let(:publisher) { 'Random House' }
  let(:cover_state) { 'good' }
  let(:publish_date) { Date.today }
  let(:book) { Book.new(publisher, cover_state, publish_date) }

  describe '#initialize' do
    it 'sets the publisher' do
      expect(book.publisher).to eq publisher
    end

    it 'sets the cover_state' do
      expect(book.cover_state).to eq cover_state
    end

    it 'sets the publish_date' do
      expect(book.publish_date).to eq publish_date
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the book object' do
      expected_output = {
        'publisher' => publisher,
        'cover_state' => cover_state,
        'publish_date' => publish_date,
        'class' => 'Book'
      }
      expect(book.to_json).to eq expected_output
    end
  end
end
