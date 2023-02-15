require_relative './book'
require 'fileutils'
require 'json'

class BookService
  def initialize
    store_dir = 'storage'
    FileUtils.mkdir_p(store_dir) unless Dir.exist?(store_dir)

    file_path = File.join(store_dir, 'books.json')
    File.write(file_path, '[]') unless File.exist?(file_path)
    file_content = File.read(file_path)
    @books = file_content.empty? ? [] : JSON.parse(file_content)
  rescue StandardError => e
    puts "Error: #{e.message} while loading books from file #{file_path}"
    @books = []
  end

  def create
    print "Publisher: "
    publisher = gets.chomp
    print "Cover State: "
    cover_state = gets.chomp
    print "Publish Date (yyyy/mm/dd): "
    publish_date = gets.chomp
    @books << Book.new(publisher, cover_state, publish_date).to_json
    write_to_file
    puts "Book created successfully"
  end

  def list
    if @books.empty?
      puts 'No books found. Please add some books to the list.'
    else
      @books.each_with_index do |book|
        puts "Publisher: #{book['publisher']}, Cover state: #{book['cover_state']}, Publish date: #{book['publish_date']}"
      end
    end
    puts
  end

  def write_to_file
    json_data = JSON.pretty_generate(@books)
    File.write(File.join('storage', 'books.json'), json_data)
  end
end
