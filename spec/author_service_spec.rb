require_relative '../classes/author_service'

describe AuthorService do
  let(:author_service) { AuthorService.new }
  let(:file_path) { 'storage/authors.json' }

  describe '#initialize' do
    it 'creates a storage directory if it does not exist' do
      FileUtils.rm_rf('storage')
      expect { author_service }.to change { Dir.exist?('storage') }.from(false).to(true)
    end

    it 'creates a authors.json file if it does not exist' do
      FileUtils.rm_f(file_path)
      expect { author_service }.to change { File.exist?(file_path) }.from(false).to(true)
      expect(File.read(file_path)).to eq('[]')
    end

    it 'loads authors from the authors.json file' do
      authors = [Author.new('First Name 1', 'Last Name 1').to_json,
                 Author.new('First Name 2', 'Last Name 2').to_json]
      File.write(file_path, JSON.generate(authors))
      author_service = AuthorService.new
      expect(author_service.instance_variable_get(:@authors)).to eq(authors)
    end

    it 'rescues any StandardError and sets authors to an empty array' do
      allow(File).to receive(:read).and_raise(StandardError)
      author_service = AuthorService.new
      expect(author_service.instance_variable_get(:@authors)).to eq([])
    end
  end

  describe '#create' do
    before do
      allow(author_service).to receive(:gets).and_return('First Name 1', 'Last Name 1', '')
    end

    it 'creates a new author with user input' do
      author_service.create
      expect { author_service.create }.to change { author_service.instance_variable_get(:@authors).length }.by(1)
      expect(author_service.instance_variable_get(:@authors).first['first_name']).to eq('First Name 1')
      expect(author_service.instance_variable_get(:@authors).first['last_name']).to eq('Last Name 1')
    end

    it 'writes the new author to the authors.json file' do
      expect(File).to receive(:write).with(file_path, kind_of(String))
      author_service.create
    end
  end

  describe '#list' do
    before do
      authors = [Author.new('First', 'Last').to_json,
                 Author.new('First', 'Last').to_json]
      File.write(file_path, JSON.generate(authors))
    end

    it 'lists all the authors in the @authors instance variable' do
      expect do
        author_service.list
      end.to output("FirstName: First, LastName: Last\nFirstName: First, LastName: Last\n\n").to_stdout
    end

    it 'displays a message if there are no authors' do
      FileUtils.rm_f(file_path)
      expect { author_service.list }.to output("No authors found. Please add some authors to the list.\n\n").to_stdout
    end
  end

  describe '#write_to_file' do
    it 'writes the current state of @authors to the authors.json file' do
      file_path = File.join('storage', 'authors.json')
      initial_file_contents = File.read(file_path)
      author_service.instance_variable_set(:@authors, [])

      author_service.write_to_file

      expect(File.read(file_path)).to_not eq(initial_file_contents)
    end
  end
end
