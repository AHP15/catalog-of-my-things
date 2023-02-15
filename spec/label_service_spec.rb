require_relative '../classes/label_service'

describe LabelService do
  let(:label_service) { LabelService.new }
  let(:file_path) { 'storage/labels.json' }

  describe '#initialize' do
    it 'creates a storage directory if it does not exist' do
      FileUtils.rm_rf('storage')
      expect { label_service }.to change { Dir.exist?('storage') }.from(false).to(true)
    end

    it 'creates a labels.json file if it does not exist' do
      FileUtils.rm_f(file_path)
      expect { label_service }.to change { File.exist?(file_path) }.from(false).to(true)
      expect(File.read(file_path)).to eq('[]')
    end

    it 'loads labels from the labels.json file' do
      labels = [Label.new('Example Label 1', '#FF0000').to_json,
                Label.new('Example Label 2', '#00FF00').to_json]
      File.write(file_path, JSON.generate(labels))
      label_service = LabelService.new
      expect(label_service.instance_variable_get(:@labels)).to eq(labels)
    end

    it 'rescues any StandardError and sets labels to an empty array' do
      allow(File).to receive(:read).and_raise(StandardError)
      label_service = LabelService.new
      expect(label_service.instance_variable_get(:@labels)).to eq([])
    end
  end

  describe '#create' do
    before do
      allow(label_service).to receive(:gets).and_return('Example Label 1', '#FF0000', '')
    end

    it 'creates a new label with user input' do
      label_service.create
      expect { label_service.create }.to change { label_service.instance_variable_get(:@labels).length }.by(1)
      expect(label_service.instance_variable_get(:@labels).first['title']).to eq('Example Label 1')
      expect(label_service.instance_variable_get(:@labels).first['color']).to eq('#FF0000')
    end

    it 'writes the new label to the labels.json file' do
      expect(File).to receive(:write).with(file_path, kind_of(String))
      label_service.create
    end
  end

  describe '#list' do
    before do
      labels = [Label.new('Example Label 1', '#FF0000').to_json,
                Label.new('Example Label 2', '#00FF00').to_json]
      File.write(file_path, JSON.generate(labels))
    end

    it 'lists all the labels in the @labels instance variable' do
      expect do
        label_service.list
      end.to output("Title: Example Label 1, Color: #FF0000\nTitle: Example Label 2, Color: #00FF00\n\n").to_stdout
    end

    it 'displays a message if there are no labels' do
      FileUtils.rm_f(file_path)
      expect { label_service.list }.to output("No labels found. Please add some labels to the list.\n\n").to_stdout
    end
  end

  describe '#write_to_file' do
    it 'writes the current state of @labels to the labels.json file' do
      file_path = File.join('storage', 'labels.json')
      initial_file_contents = File.read(file_path)
      label_service.instance_variable_set(:@labels, [])

      label_service.write_to_file

      expect(File.read(file_path)).to_not eq(initial_file_contents)
    end
  end
end
