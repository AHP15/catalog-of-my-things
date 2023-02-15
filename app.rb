require 'fileutils'
require 'json'
require_relative './client'
require_relative './classes/book_service'
require_relative './classes/label_service'

class App
  attr_reader :client

  def initialize
    @books = BookService.new
    @items = []
  end

  def list_data(option)
    case option
    when '1'
      @books.list
    when '6'
      @books.label_list
    end
  end

  def add_data(option)
    # you can ask the user for more input based on the option
    # you can do something like this 'book_info = @client.book_info'
    # the book_info() will be implemented on the Client class
    case option
    when '9'
      @books.create
    end
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
