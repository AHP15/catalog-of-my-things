require_relative './author'
require 'fileutils'
require 'json'

class AuthorService
  def initialize
    store_dir = 'storage'
    FileUtils.mkdir_p(store_dir)

    file_path = File.join(store_dir, 'authors.json')
    File.write(file_path, '[]') unless File.exist?(file_path)
    file_content = File.read(file_path)
    @authors = file_content.empty? ? [] : JSON.parse(file_content)
  rescue StandardError => e
    puts "Error: #{e.message} while loading books from file #{file_path}"
    @authors = []
  end

  def create
    print 'First name: '
    first_name = gets.chomp
    print 'Last name: '
    last_name = gets.chomp
    @authors << Author.new(first_name, last_name).to_json
    write_to_file
    puts "Author created successfully\n"
  end

  def list
    if @authors.empty?
      puts 'No authors found. Please add some authors to the list.'
    else
      @authors.each do |author|
        puts "FirstName: #{author['first_name']}, LastName: #{author['last_name']}"
      end
    end
    puts
  end

  def write_to_file
    json_data = JSON.pretty_generate(@authors)
    File.write(File.join('storage', 'authors.json'), json_data)
  end
end
