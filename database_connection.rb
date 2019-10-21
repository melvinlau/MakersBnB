# ENV['ENVIRONMENT'] is set in spec/spec_helper.rb
if ENV['ENVIRONMENT'] == 'test'
  DBConnection.setup('makersbnb_test')
else
  DBConnection.setup('makersbnb')
end
