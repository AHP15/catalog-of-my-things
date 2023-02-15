

















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
