# DinnerClub Code
# Dinner Club

require './club_event_code_copy.rb'

class DinnerClub

  attr_accessor :running_balance, :club_history

  # Creates an empty hash to store the dinner club members and their balance.
  # Makes the default value of the hash 0, so that new members can be added.
  # Makes a club_history hash as empty.
  def initialize
    @running_balance = {}
    running_balance.default = 0
    @club_history = {}
  end

  # Creates a new dinner event for when some people go out.
  #
  # total_cost - integer passed by the user when the method is run.
  # tip_percentage - float or integer passed by the user when the method is run.
  # people - array of attendees passed by user when the method is run.
  # date - string passed by the user.
  # location - string passed by the user.
  # who_paid - string passed by the user.
  #
  # Returns nothing.
  def new_event(total_cost, tip_percentage, people, date, location, who_paid)
    event = ClubEvent.new(total_cost, tip_percentage, people, date, location, who_paid)
    club_history_update(club_history, event.event_log)
    running_balance_update(running_balance, event.event_log)
    display_running_balance(running_balance)
  end

  # Updates the all_events hash if a new event takes place.
  #
  # club_history - Hash with the date as a key and an array as the value.
  #   the array contains location, and the attendees_hash, both created in
  #   the new_event method.
  # event_log - Hash taken from the ClubEvent Class's event_update method.
  #
  # Returns the updated club_history Hash.
  def club_history_update(club_history, event_log)
    club_history.merge!(event_log)
  end

  # Updates the balance if a new dinner event occurred.
  #
  # running_balance - Hash that is continually being updated as a new event
  #   occurs.
  # club_history - Hash with the date as a key and the value as an Array. Array
  #   contains the location and the attendees_hash (from ClubEvent class).
  #   attendees_hash contains the member name and the cost member paid at event.
  #
  # Returns the club_history Hash
  def running_balance_update(running_balance, club_history)
    club_history.each do |date, array|
      array[1].each do |name, amount|
        running_balance[name] += amount
      end
    end
  end

  # Displays the current running balance of each member of DinnerClub.
  #
  # Returns the running_balance Hash formatted for display.
  def display_running_balance(running_balance)
    puts "\n"
    puts "Member Name".ljust(20) + "Member Balance".rjust(10)
    35.times {print "-"}
    puts "\n"
    running_balance.each do |name, balance|
      puts "#{name}".ljust(20) + "$#{sprintf("%0.2f", balance)}".rjust(10)
    end
    puts "\n"
  end

  # Displays the log of events nicely. Will only show if called specifically.
  #
  # club_history - Hash with the date as a key, value is an Array with location
  #   and the attendees_hash. attendees_hash has a key of member name and value
  #   of cost paid at the event.
  #
  # Returns club_history Hash formatted for display.
  def display_history(club_history)
    puts "\n"
    puts "Date\t\tLocation\t" + "Members and Payments".rjust(25)
    65.times {print "-"}
    puts "\n"
    club_history.each do |date, array|
      puts "#{date}\t#{array[0]}\t\t" + "#{array[1]}".rjust(25)
    end
  end

end
