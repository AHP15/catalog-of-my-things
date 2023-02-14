require_relative './app'

def main
  app = App.new
  app.run
  puts 'Thank you for using our app!'
  app.store_data
end

main
