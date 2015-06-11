# Resource Class
require "sqlite3"


# Creates the database connection
DATABASE = SQLite3::Database.new("pets.db")

# Creates the table
DATABASE.execute("CREATE TABLE IF NOT EXISTS cats (id INTEGER PRIMARY KEY, name TEXT, age INTEGER);")

# Returns the results as a Hash
DATABASE.results_as_hash = true

# Adds a new entry to the Database
def add_pet(name, age)
  DATABASE.execute("INSERT INTO cats (name, age) VALUES ('#{name}', #{age});")
end

# Reads the entire table
def show_table
  DATABASE.execute("SELECT * FROM cats;")
end

# Show all ages
def show_all_names
  DATABASE.execute("SELECT name FROM cats;")
end

# Show all ages
def show_all_ages
  DATABASE.execute("SELECT age FROM cats;")
end

# Shows the cat name (String) from id (Integer)
def pet_name(id)
  name = DATABASE.execute("SELECT name FROM cats WHERE id = #{id};")
  name.first["name"]
end

# Shows the cat age (Integer) from id (Integer)
def pet_age(id)
  age = DATABASE.execute("SELECT age FROM cats WHERE id = #{id};")
  age.first["age"]
end

# Updates the age (Integer) when the id (Integer) is passed
def update_age(id, new_age)
  DATABASE.execute("UPDATE cats SET age = #{new_age} WHERE id = #{id};")
end

# Deletes an entry
def remove_pet(id)
  DATABASE.execute("DELETE FROM cats WHERE id = #{id};")
end
