# Club Event Copy

# Club Event

require './checksplitter_code.rb'

class ClubEvent

  attr_accessor :total_cost, :people, :tip_percentage, :attendees_hash, :per_person, :date, :location, :event_log, :who_paid, :total_cost_single_pay

  # Creates six variables and runs three methods, so that when a new event is
  # created, it automatically calculates costs and updates tables.
  #
  # total_cost - integer passed by user
  # tip_percentage - either an integer or float, passed by user
  # people - array, passed by the user
  # date - string, passed by user
  # location - string, passed by user
  # who_paid - string, passed by user
  #
  # Runs the define_costs_for_event method to store the per_person attribute and
  # the total_cost_single_pay attribute.
  # Runs the store_attendees_and_costs method to create the attendees_hash
  # instance variable.
  # Runs the event_update method to store the event information in the
  # event_log hash, stored as an instance variable.
  def initialize(total_cost, tip_percentage, people = [], date, location, who_paid)
    @total_cost = total_cost
    @people = people
    @tip_percentage = tip_percentage
    @date = date
    @location = location
    @who_paid = who_paid
    define_costs_for_event(total_cost, people, tip_percentage)
    store_attendees_and_costs(who_paid, people, per_person)
    event_history_update(date, location, attendees_hash)
  end

  # Creates a CheckSplitter object and stores a per person cost.
  #
  # Creates the new CheckSplitter object by passing the stored information
  # as the paramaters.
  #
  # Stores the per_person cost as an instance variable - float.
  # Runs the event_update method.
  # Stores the total_cost_single_pay as an instance variable to use later if
  # one person pays - float.
  def define_costs_for_event(total_cost, people, tip_percentage)
    dinner_event_split = CheckSplitter.new(total_cost: total_cost, people: people.length, tip_percentage: tip_percentage)
    @per_person = dinner_event_split.final_per_person
    @total_cost_single_pay = dinner_event_split.total_cost_with_tip
  end

  # Creates a hash of people and the per_person cost of the event using the
  #    as the key and per_person as the value.
  #
  # per_person - float created from the define_costs_for_event method; instance
  #   variable.
  # who_paid - string passed by user
  # people - array passed by user
  #
  # Uses and ifelse to evaluate if everyone paid or one person paid.
  # If everyone paid, it calls the populate_attendees_hash method and passes
  #   the per_person as the value.
  # If < everyone paid, it calls the populate_attendees_hash method and passes
  #   0 as the value, then modifies the attendees_hash for the key of who_paid
  #   and sets their value equal to total_cost_single_pay, a float created from
  #   the define_costs_for_event method.
  # Stores the attendees_hash as another instance variable.
  def store_attendees_and_costs(who_paid, people, per_person)
    @attendees_hash = {}
    if who_paid.downcase == "everyone"
      populate_attendees_hash(people, per_person)
    else
      populate_attendees_hash(people, 0)
      attendees_hash[who_paid] = total_cost_single_pay
    end
  end

  # This is a utitily function that will be called within the
  #   store_attendees_and_costs method
  #
  # people - array input from user
  # per_person - float - instance variable created from the
  #   define_costs_for_event method
  #
  # Iterates over people and populates the attendees_hash with each person who
  #   attended an event and the cost they paid.
  def populate_attendees_hash(people, per_person)
    people.each do |person, money|
      attendees_hash[person] = per_person
    end
  end

  # Creates a hash of events dates, locations, and people.
  #
  # event_log - Hash stored as an instance variable; key is date, value is an
  #   array of the location and attendees_hash.
  # date - String passed by user
  # location - String passed by user
  # attendees_hash - hash with key as member and value as cost; created in the
  #   store_attendees_and_costs method.
  def event_history_update(date, location, attendees_hash)
    @event_log = {date => [location, attendees_hash]}
  end

end
