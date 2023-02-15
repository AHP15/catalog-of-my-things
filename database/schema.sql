CREATE TABLE book(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  items_id INT REFERENCES items(id),
  publish_date DATE,
  publisher VARCHAR(100),
  cover_state VARCHAR(100)
);

CREATE TABLE label(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title VARCHAR(100),
  color VARCHAR(100),
  items ARRAY
)
CREATE TABLE music_album(
  id INT GENERATED ALWAYS AS IDENTITY,
  on_spotify BOOLEAN,
  publish_date VARCHAR(12),
  genre VARCHAR(20),
  label VARCHAR(20),
  source VARCHAR(20),
  author VARCHAR(20),
  PRIMARY KEY(id)
);

CREATE TABLE genre(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(20),
  items ARRAY,
  PRIMARY KEY(id)
)
