require 'fileutils'
require 'json'
require_relative './client'
require_relative './classes/book_service'
require_relative './classes/label_service'
require_relative './classes/music_album'

class App
  attr_reader :client

  def initialize
    @books = BookService.new
    @items = []
    @genres = data('storage', 'genres.json') || []
    @music_albums = data('storage', 'music_albums.json') || []
  end

  def data(directory, filename)
    FileUtils.mkdir_p(directory)
    file_path = "./#{directory}/#{filename}"
    File.exist?(file_path) && JSON.parse(File.read(file_path))
  end

  def store_data
    File.write('./storage/genres.json', JSON.pretty_generate(@genres))
    File.write('./storage/music_albums.json', JSON.pretty_generate(@music_albums))
  end

  def list_data(option)
    case option
    when '1'
      @books.list
    when '2'
      @client.print_data(@music_albums)
    when '5'
      @client.print_data(@genres)
    when '6'
      @books.label_list
    end
  end
  # we can add more cases here

  def add_data(option)
    case option
    when '9'
      @books.create
    when '10'
      album_data = @client.album_info
      music_album = MusicAlbum.new(album_data['publish_date'], album_data['on_spotify'])
      @music_albums << music_album.to_hash
    end
    # we can add more cases here
  end

  def run
    loop do
      @client = Client.new
      option = client.option
      break if option == '13'

      list_data(option) if option.to_i <= 8
      add_data(option) if option.to_i > 8
    end
  end
end
