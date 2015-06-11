# Check Splitter as a Database
require "sqlite3"
require_relative "checksplitter_code.rb"

# Creates the database connection
DATABASE = SQLite3::Database.new("bills.db")

# Creates the table
DATABASE.execute("CREATE TABLE IF NOT EXISTS split_checks (id INTEGER PRIMARY KEY, total_cost INTEGER, tip_percentage INTEGER, people INTEGER, total_cost_with_tip INTEGER, final_per_person INTEGER);")

# Returns the results as a Hash
DATABASE.results_as_hash = true

# Show everything in the table
def show_table
  DATABASE.execute("SELECT * FROM split_checks;")
end

# Show total_cost_with_tip (Float)
def show_total_cost_with_tip
  DATABASE.execute("SELECT total_cost_with_tip FROM split_checks;")
end

# Show final_per_person (Float)
def show_final_per_person
  DATABASE.execute("SELECT final_per_person FROM split_checks;")
end

# Show total_cost (Float)
def show_final_per_person
  DATABASE.execute("SELECT total_cost FROM split_checks;")
end

# Show tip_percentage (Float)
def show_final_per_person
  DATABASE.execute("SELECT tip_percentage FROM split_checks;")
end

# Show people (Integer)
def show_final_per_person
  DATABASE.execute("SELECT people FROM split_checks;")
end

# Update tip_percentage (Float)
#
# id - Integer
# new_tip - Float
#
# Returns nothing.
def update_tip(id, new_tip)
  DATABASE.execute("UPDATE split_checks SET tip_percentage = #{new_tip} WHERE id = #{id};")
end

# Update total_cost (Float)
#
# id - Integer
# new_cost - Integer
#
# Returns nothing
def update_total_cost(id, new_cost)
  DATABASE.execute("UPDATE split_checks SET total_cost = #{new_cost} WHERE id = #{id};")
end

# Update the number of people (Integer)
#
# id - Integer
# new_number_of_people - Integer
#
# Returns nothing
def update_number_of_people(id, new_number_of_people)
  DATABASE.execute("UPDATE split_checks SET people = #{new_number_of_people} WHERE id = #{id};")
end

# Add a new Check with CheckSplitter object and adds to database
#
# total_cost - Integer
# tip_percentage - Float
# people - Integer
#
# Returns nothing
def add_check(total_cost, tip_percentage, people)
  new_check = CheckSplitter.new(total_cost: total_cost, tip_percentage: tip_percentage, people: people)
  new_entry(total_cost, tip_percentage, people, new_check.total_cost_with_tip, new_check.final_per_person)
end

# Utility method - Adds a new entry to the split_checks table
#
# total_cost - Integer
# tip_percentage - Float
# people - Integer
# total_cost_with_tip - Float; calculated from CheckSplitter
# final_per_person - Float; calculated from CheckSplitter
#
# Returns nothing.
def new_entry (total_cost, tip_percentage, people, total_cost_with_tip, final_per_person)
  DATABASE.execute("INSERT INTO split_checks (total_cost, tip_percentage, people, total_cost_with_tip, final_per_person) VALUES (#{total_cost}, #{tip_percentage}, #{people}, #{total_cost_with_tip}, #{final_per_person});")
end

# Remove a split_checks entry
#
# id - Integer
#
# Returns nothing
def remove_check(id)
  DATABASE.execute("DELETE FROM split_checks WHERE id = #{id};")
end
