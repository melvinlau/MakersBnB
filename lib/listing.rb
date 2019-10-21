class Listing

  def self.create(name:, description:, price:, location:, photo_src:, available_date:, user_id:)

    escaped_name = name.gsub("'", "''")
    escaped_description = description.gsub("'", "''")
    escaped_location = location.gsub("'", "''")


    sql = "INSERT INTO listings (name, description, price, location, photo_src, available_date, user_id) "
    sql += "VALUES('#{escaped_name}', '#{escaped_description}', '#{price}'), "
    sql += "'#{escaped_location}', '#{photo_src}', '#{available_date}', '#{user_id}'), "
    sql += "RETURNING id, name, description, price, location, photo_src, available_date, user_id;"
    result = DBConnection.query(sql)

    Listing.new(
      id: result[0]['id'],
      name: result[0]['name'],
      description: result[0]['description'],
      price: result[0]['price'],
      location: result[0]['location'],
      photo_src: result[0]['photo_src'],
      available_date: result[0]['available_date'],
      user_id: result[0]['user_id']
    )

  end

  attr_reader :id, :name, :description, :price, :location, :photo_src, :available_date, :user_id

  def initialize(id:, name:, description:, price:, location:, photo_src:, available_date:, user_id:)
    @id = id
    @name = name
    @description = description
    @price = price
    @location = location
    @photo_src = photo_src
    @available_date = available_date
    @user_id = user_id
  end

end
