require_relative '../classes/book_service'

describe BookService do
  let(:book_service) { BookService.new }
  let(:file_path) { 'storage/books.json' }

  describe '#initialize' do
    it 'creates a storage directory if it does not exist' do
      FileUtils.rm_rf('storage')
      expect { book_service }.to change { Dir.exist?('storage') }.from(false).to(true)
    end

    it 'creates a books.json file if it does not exist' do
      FileUtils.rm_f(file_path)
      expect { book_service }.to change { File.exist?(file_path) }.from(false).to(true)
      expect(File.read(file_path)).to eq('[]')
    end

    it 'loads books from the books.json file' do
      books = [Book.new('Test Publisher 1', 'Good', '2023/02/15').to_json,
               Book.new('Test Publisher 2', 'Good', '2023/02/15').to_json]
      File.write(file_path, JSON.generate(books))
      book_service = BookService.new
      expect(book_service.instance_variable_get(:@books)).to eq(books)
    end

    it 'rescues any StandardError and sets labels to an empty array' do
      allow(File).to receive(:read).and_raise(StandardError)
      book_service = BookService.new
      expect(book_service.instance_variable_get(:@books)).to eq([])
    end
  end

  describe '#create' do
    context 'when given inputs' do
      it 'adds a book to the list of books' do
        allow(book_service).to receive(:gets).and_return('Test Publisher', 'Good', '2023/02/15', '2')
        initial_book_count = book_service.instance_variable_get(:@books).count

        book_service.create

        expect(book_service.instance_variable_get(:@books).count).to eq(initial_book_count + 1)
      end
    end
  end

  describe '#label_list' do
    it 'calls the #list method of the LabelService object' do
      expect(book_service.instance_variable_get(:@labels)).to receive(:list)

      book_service.label_list
    end
  end

  describe '#list' do
    context 'when there are books in the list' do
      it 'prints the details of each book in the list' do
        book = Book.new('Test Publisher', 'Good', '2023/02/15')
        book_json = book.to_json
        book_service.instance_variable_set(:@books, [book_json])

        expect { book_service.list }.to output(/Publisher: #{book.publisher}/).to_stdout
      end
    end

    context 'when there are no books in the list' do
      it 'prints a message indicating that there are no books' do
        book_service.instance_variable_set(:@books, [])

        expect { book_service.list }.to output(/No books found/).to_stdout
      end
    end
  end

  describe '#write_to_file' do
    it 'writes the contents of @books to a JSON file' do
      file_path = File.join('storage', 'books.json')
      initial_file_contents = File.read(file_path)
      book_service.instance_variable_set(:@books, [])

      book_service.write_to_file

      expect(File.read(file_path)).to_not eq(initial_file_contents)
    end
  end
end
