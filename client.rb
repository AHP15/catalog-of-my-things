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

    puts 'Please shoose an option by entring a number:'

    options.each_with_index do |option, i|
      puts "#{i + 1} - #{option}"
    end

    @option = gets.chomp
  end

  def validate_input(message, validation = ->(input) do input != '' end)
    loop do
      print message
      input = gets.chomp
      puts 'Invalid Input' unless validation.call(input)
      return input if validation.call(input)
    end
  end

  def book_info
    # this function is not implemented yet
    # you can ask the user to input data and then return it as on object
    # so the App class will use to add the data
  end

  def album_info
    # get the publish date
    date_regex = %r{^\d{4}/\d{2}/\d{2}$}
    message = 'Publish date (yyyy/mm/dd): '
    publish_date = validate_input(message, ->(input) do input.match(date_regex) end)

    # on spotify?
    message = 'Is on Spotify: '
    possible_input = %w[true false True False t f T F]
    on_spotify = validate_input(message, ->(input) do possible_input.include?(input) end)

    # return the data
    true_inputs = %w[true True t T]
    { 'publish_date' => publish_date, 'on_spotify' => true_inputs.include?(on_spotify) }
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

  def print_data(data)
    data.each do |obj|
      message = ''

      obj.each do |key, value|
        message += "#{key}: #{value}, " unless value.nil?
      end

      puts message
    end
  end
end
