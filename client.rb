class Client
  attr_reader :option

  def initialize
    options = [
      'List all books',
      'List all music albums',
      'List all movies',
      'List all games',
      'List all genres',
      'List all labels',
      'List all authors',
      'List all sources',
      'Add a book',
      'Add a music album',
      'Add a movie',
      'Add a game',
      'Exit'
    ]

    puts 'Please choose an option by entering a number:'

    options.each_with_index do |option, i|
      puts "#{i + 1} - #{option}"
    end

    @option = gets.chomp
  end

  def book_info
    # this function is not implemented yet
    # you can ask the user to input data and then return it as on object
    # so the App class will use to add the data
  end

  def album_info
    # this function is not implemented yet
    # you can ask the user to input data and then return it as on object
    # so the App class will use to add the data
  end

  def movie_info
    # this function is not implemented yet
    # you can ask the user to input data and then return it as on object
    # so the App class will use to add the data
  end

  def game_info
    # this function is not implemented yet
    # you can ask the user to input data and then return it as on object
    # so the App class will use to add the data
  end
end
