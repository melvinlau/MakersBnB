require 'pg'

def setup_test_database
  puts "\e[37m  Setting up test database...\e[0m"
  DBConnection.setup('makersbnb_test')
  DBConnection.query("TRUNCATE users, listings;") # Reset before each test
end
