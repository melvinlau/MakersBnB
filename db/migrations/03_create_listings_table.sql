CREATE TABLE listings(
  id SERIAL PRIMARY KEY,
  name VARCHAR(60),
  description VARCHAR(300),
  price FLOAT,
  location VARCHAR(60),
  photo_src VARCHAR(60),
  available_date DATE,
  user_id VARCHAR(60));
