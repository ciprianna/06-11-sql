# Check Splitter Info

# Check Splitter

# Creates new class called CheckSplitter
class CheckSplitter

  # Shows which attributes are accessible
  attr_accessor :total_cost, :tip_percentage, :people, :args

  # Initializes the attributes as optional; sets default values in the options
  # hash and merges the hash with inputs (if given). Uses those defaults as
  # initialized attributes. Calls methods below with args as an argument.
  def initialize(args = {})
    options = {total_cost: 20, tip_percentage: 0.15, people: 2}
    @args = options.merge(args)
    @total_cost = args[:total_cost]
    tip_percent(@args)
    people_count(@args)
    neg_tip(@args)
  end


  # Makes the default value a decimal, so the user can input either integers or
  # floats.
  #
  # args - Hash that we will pull the :tip_percentage value out. This value is
  #   a Float.
  #
  # Returns an instance variable called tip_percentage, containing a Float.
  def tip_percent(args)
    tip_percent_temp = args[:tip_percentage].to_f
    if tip_percent_temp >= 1
      @tip_percentage = (tip_percent_temp / 100.0)
    else
      @tip_percentage = tip_percent_temp
    end
  end

  # Checks if the tip input was negative; if so, sets it to 0.15
  def neg_tip(args)
    tip_percent_temp = args[:tip_percentage].to_f
    if tip_percent_temp < 0
      @tip_percentage = 0.15
    end
  end

  # Evaluates the people input; if the input is less than 1, it sets it to 1
  def people_count(args)
    people_temp = args[:people]
    if people_temp < 1
      @people = 1
    else
      @people = people_temp
    end
  end

  # Total cost of the meal with tip
  def total_cost_with_tip
    total_cost + (total_cost * tip_percentage)
  end

  # Divides the total cost by the number of people
  def base_cost_per_person
    total_cost / people
  end

  # Multiplies the total cost by the tip percentage, then divides that by the
  # number of people
  def tip_per_person
    (total_cost * tip_percentage) / people
  end

  # Adds the total cost of the meal per person and the tip per person
  def final_per_person
    self.tip_per_person + self.base_cost_per_person
  end


end
