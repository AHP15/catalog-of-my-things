require_relative './label'
require 'fileutils'
require 'json'

class LabelService
  def initialize
    store_dir = 'storage'
    FileUtils.mkdir_p(store_dir)

    file_path = File.join(store_dir, 'labels.json')
    File.write(file_path, '[]') unless File.exist?(file_path)
    file_content = File.read(file_path)
    @labels = file_content.empty? ? [] : JSON.parse(file_content)
  rescue StandardError => e
    puts "Error: #{e.message} while loading books from file #{file_path}"
    @labels = []
  end

  def create
    print 'Title: '
    title = gets.chomp
    print 'Color: '
    color = gets.chomp
    @labels << Label.new(title, color).to_json
    write_to_file
    puts "Label created successfully\n"
  end

  def list
    if @labels.empty?
      puts 'No labels found. Please add some labels to the list.'
    else
      @labels.each do |label|
        puts "Title: #{label['title']}, Color: #{label['color']}"
      end
    end
    puts
  end

  def write_to_file
    json_data = JSON.pretty_generate(@labels)
    File.write(File.join('storage', 'labels.json'), json_data)
  end
end
