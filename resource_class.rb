# Resource Class
require "sqlite3"


# Creates the database connection
DATABASE = SQLite3::Database.new("pets.db")

# Creates the table
DATABASE.execute("CREATE TABLE cats (id INTEGER PRIMARY KEY, name TEXT, age INTEGER);")

# Returns the results as a Hash
DATABASE.results_as_hash = true
