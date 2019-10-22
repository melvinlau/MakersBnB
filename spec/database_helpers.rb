require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'makersbnb')
  connection.exec('TRUNCATE TABLE users;')
end
