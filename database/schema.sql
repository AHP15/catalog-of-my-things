CREATE TABLE music_album(
  id INT GENERATED ALWAYS AS IDENTITY,
  on_spotify BOOLEAN,
  publish_date VARCHAR(12),
  genre VARCHAR(20),
  label VARCHAR(20),
  sourse VARCHAR(20),
  author VARCHAR(20),
  PRIMARY KEY(id)
);

CREATE TABLE genre(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(20),
  items ARRAY,
  PRIMARY KEY(id)
)