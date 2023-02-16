require 'fileutils'
require 'json'
require_relative './game'
require_relative './author_service'

class GameService
  def initialize
    @authors = AuthorService.new
    store_dir = 'storage'
    FileUtils.mkdir_p(store_dir)

    file_path = File.join(store_dir, 'games.json')
    File.write(file_path, '[]') unless File.exist?(file_path)
    file_content = File.read(file_path)
    @games = file_content.empty? ? [] : JSON.parse(file_content)
  rescue StandardError => e
    puts "Error: #{e.message} while loading books from file #{file_path}"
    @games = []
  end

  def create
    print 'Multiplayer(Type [Yes/No]): '
    multiplayer = gets.chomp
    print 'Last played at (yyyy/mm/dd): '
    last_played_at = gets.chomp
    print 'Publish Date (yyyy/mm/dd): '
    publish_date = gets.chomp
    @games << Game.new(multiplayer, last_played_at, publish_date).to_json
    write_to_file
    puts "Game created successfully\n"
    puts 'Would you like to add author? (1)- Yes // (2)- No'
    options = gets.chomp.to_i
    return unless options == 1

    @authors.create
  end

  def authors_list
    @authors.list
  end

  def list
    if @games.empty?
      puts 'No games found. Please add some games to the list.'
    else
      @games.each do |game|
        puts
        print "Multiplayer: #{game['multiplayer']}, "
        print "Last_Played_at: #{game['last_played_at']}, Publish date: #{game['publish_date']}"
      end
      puts
    end
    puts
  end

  def write_to_file
    json_data = JSON.pretty_generate(@games)
    File.write(File.join('storage', 'games.json'), json_data)
  end
end
