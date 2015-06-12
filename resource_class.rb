# Resource Class
require "sqlite3"
require_relative "class_for_resource_database.rb"


# Creates the database connection
DATABASE = SQLite3::Database.new("pets.db")

# Creates the table
DATABASE.execute("CREATE TABLE IF NOT EXISTS cats (id INTEGER PRIMARY KEY, name TEXT, age INTEGER);")

# Returns the results as a Hash
DATABASE.results_as_hash = true
