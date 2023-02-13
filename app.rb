require_relative './client'

class App
  attr_reader :client

  def initialize
    @items = []
  end

  def list_data(option)
    # this function is not implemented yet
    puts @client
    puts option
  end

  def add_data(option)
    # this function is not implemented yet
    # you can ask the user for more input based on the option
    # you can do something like this 'book_info = @client.book_info'
    # the book_info() will be implemented on the Client class
    puts @client
    puts option
  end

  def run
    loop do
      @client = Client.new
      option = client.option
      break if option == '13'

      list_data(option) unless option.to_i <= 8
      add_data(option) unless option.to_i > 8
    end
  end
end
