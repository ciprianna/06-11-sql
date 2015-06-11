# Database Access for DinnerClub
require "sqlite3"
require_relative "dinnerclub_code_copy.rb"

# Creates the database connection
DATABASE = SQLite3::Database.new("dinner_clubs.db")

# Creates the table for club_history
DATABASE.execute("CREATE TABLE IF NOT EXISTS club_history (id INTEGER PRIMARY KEY, date DATE, location TEXT, attendees_and_cost TEXT);")

# Creates the table for running_member_tab
DATABASE.execute("CREATE TABLE IF NOT EXISTS running_member_tab (name TEXT, total_cost INTEGER)")

# Returns the results as a Hash
DATABASE.results_as_hash = true

# Reads club_history table
def show_club_history
  DATABASE.execute("SELECT * FROM club_history;")
end

# Reads running_member_tab table
def show_running_member_tab
  DATABASE.execute("SELECT * FROM running_member_tab;")
end
