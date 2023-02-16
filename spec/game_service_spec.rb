require_relative '../classes/game_service'

describe GameService do
  let(:game_service) { GameService.new }
  let(:file_path) { 'storage/games.json' }

  describe '#initialize' do
    it 'creates a storage directory if it does not exist' do
      FileUtils.rm_rf('storage')
      expect { game_service }.to change { Dir.exist?('storage') }.from(false).to(true)
    end

    it 'creates a games.json file if it does not exist' do
      FileUtils.rm_f(file_path)
      expect { game_service }.to change { File.exist?(file_path) }.from(false).to(true)
      expect(File.read(file_path)).to eq('[]')
    end

    it 'loads games from the games.json file' do
      games = [Game.new('Yes', '2003/02/16', '2023/02/16').to_json,
               Game.new('NO', '2003/02/16', '2023/02/16').to_json]
      File.write(file_path, JSON.generate(games))
      game_service = GameService.new
      expect(game_service.instance_variable_get(:@games)).to eq(games)
    end

    it 'rescues any StandardError and sets authors to an empty array' do
      allow(File).to receive(:read).and_raise(StandardError)
      game_service = GameService.new
      expect(game_service.instance_variable_get(:@games)).to eq([])
    end
  end

  describe '#create' do
    context 'when given inputs' do
      it 'adds a game to the list of games' do
        allow(game_service).to receive(:gets).and_return('Yes', '2003/02/16', '2023/02/16', '2')
        initial_game_count = game_service.instance_variable_get(:@games).count

        game_service.create

        expect(game_service.instance_variable_get(:@games).count).to eq(initial_game_count + 1)
      end
    end
  end

  describe '#author_list' do
    it 'calls the #list method of the AuthorService object' do
      expect(game_service.instance_variable_get(:@authors)).to receive(:list)

      game_service.authors_list
    end
  end

  describe '#list' do
    context 'when there are games in the list' do
      it 'prints the details of each game in the list' do
        game = Game.new('Test Publisher', 'Good', '2023/02/15')
        game_json = game.to_json
        game_service.instance_variable_set(:@games, [game_json])

        expect { game_service.list }.to output(/Multiplayer: #{game.multiplayer}/).to_stdout
      end
    end

    context 'when there are no games in the list' do
      it 'prints a message indicating that there are no games' do
        game_service.instance_variable_set(:@games, [])

        expect { game_service.list }.to output(/No games found/).to_stdout
      end
    end
  end

  describe '#write_to_file' do
    it 'writes the contents of @games to a JSON file' do
      file_path = File.join('storage', 'games.json')
      initial_file_contents = File.read(file_path)
      game_service.instance_variable_set(:@games, [])

      game_service.write_to_file

      expect(File.read(file_path)).to_not eq(initial_file_contents)
    end
  end
end
