# Class for Database Connection

class Pet

  def initialize(id)
    @id = id
  end

  # Adds a new entry to the Database
  def self.add(name, age)
    DATABASE.execute("INSERT INTO cats (name, age) VALUES ('#{name}', #{age});")
  end

  # Reads the entire table
  def self.all
    DATABASE.execute("SELECT * FROM cats;")
  end

  # Show all ages
  def self.all_names
    DATABASE.execute("SELECT name FROM cats;")
  end

  # Show all ages
  def self.all_ages
    DATABASE.execute("SELECT age FROM cats;")
  end

  # Shows the cat name (String) from id (Integer)
  def name
    name = DATABASE.execute("SELECT name FROM cats WHERE id = #{@id};")
    name.first["name"]
  end

  # Shows the cat age (Integer) from id (Integer)
  def age
    age = DATABASE.execute("SELECT age FROM cats WHERE id = #{@id};")
    age.first["age"]
  end

  # Updates the age (Integer) when the id (Integer) is passed
  def update_age(new_age)
    DATABASE.execute("UPDATE cats SET age = #{new_age} WHERE id = #{@id};")
  end

  # Deletes an entry
  def remove
    DATABASE.execute("DELETE FROM cats WHERE id = #{@id};")
  end

end
