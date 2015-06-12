# Database Access for DinnerClub
require "sqlite3"
require_relative "dinnerclub_code_copy.rb"

# Creates the database connection
DATABASE = SQLite3::Database.new("dinner_clubs.db")

# Creates the table for club_history
DATABASE.execute("CREATE TABLE IF NOT EXISTS club_history (id INTEGER PRIMARY KEY, date TEXT, location TEXT, attendees_and_cost TEXT);")

# Creates the table for running_member_tab
DATABASE.execute("CREATE TABLE IF NOT EXISTS running_member_tab (name TEXT PRIMARY KEY, total_cost INTEGER);")

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

# Adds a new event to the club_history table
def add_club_event(total_cost, tip_percentage, people, date, location, who_paid)
  new_event = DinnerClub.new
  new_event.new_event(total_cost, tip_percentage, people, date, location, who_paid)
  DATABASE.execute("INSERT INTO club_history (date, location) VALUES ('#{date}', '#{location}');")
  populate_running_member_tab(new_event.running_balance)
end

# Populates the running_member_tab table when an event is added
def populate_running_member_tab(running_balance)
  running_balance.each do |name, cost|
    DATABASE.execute("INSERT INTO running_member_tab (name) VALUES ('#{name}');")
    current_total = DATABASE.execute("SELECT total_cost FROM running_member_tab WHERE name = #{name};").first['total_cost']
    DATABASE.execute("UPDATE running_member_tab SET total_cost = #{total_cost + cost} WHERE name = #{'name'};")
  end
end
