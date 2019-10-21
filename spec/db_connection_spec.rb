require 'pg'
require 'db_connection'

describe DBConnection do

  describe '.setup' do
    it 'establishes a connection to the database' do
      expect(PG).to receive(:connect).with(dbname: 'makersbnb_test')
      DBConnection.setup('makersbnb_test')
    end
  end

  describe '.query' do
    it 'executes a SQL query on the connected database' do
      db = DBConnection.setup('makersbnb_test')
      expect(db).to receive(:exec).with('SELECT * FROM users;')
      DBConnection.query('SELECT * FROM users;')
    end
  end

end
