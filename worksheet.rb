########################################################
# Step 1: Establish the layers

# In this section of the file, as a series of comments,
# create a list of the layers you identify:
  #driver_id, rides, date, cost, rider_id, rating
# Which layers are nested in each other?
  # driver id < rides < date - cost - rider_id - rating
# Which layers of data "have" within it a different layer?
  # each ride has ride-specific info within it
# Which layers are "next" to each other?
# driver_ids and date - cost - rider_id - rating

########################################################
# Step 2: Assign a data structure to each layer

# Copy your list from above, and in this section
# determine what data structure each layer should have:
#   drivers_hash = hash
#   each driver_id(key) within it contains array(value) of
#   hashes which contain ride-specific info
########################################################
# Step 3: Make the data structure!

# Setup the entire data structure:
# based off of the notes you have above, create the
# and manually write in data presented in rides.csv
# You should be copying and pasting the literal data
# into this data structure, such as "DR0004"
# and "3rd Feb 2016" and "RD0022"
#
drivers_hash = {
    DR0001: [
        {
            date: "3rd Feb 2016",
            cost: 10,
            rider_id: "RD0003",
            rating: 3
        },
        {
            date: "3rd Feb 2016",
            cost: 30,
            rider_id: "RD0015",
            rating: 4
        },
        {
            date: "5th Feb 2016",
            cost: 45,
            rider_id: "RD0003",
            rating: 2
        }
    ],
    DR0002: [
        {
            date: "3rd Feb 2016",
            cost: 25,
            rider_id: "RD0073",
            rating: 5
        },
        {
            date: "4th Feb 2016",
            cost: 15,
            rider_id: "RD0013",
            rating: 1
        },
        {
            date: "5th Feb 2016",
            cost: 35,
            rider_id: "RD0066",
            rating: 3
        }
    ],
    DR0003: [
        {
            date: "4th Feb 2016",
            cost: 5,
            rider_id: "RD0066",
            rating: 5
        },
        {
            date: "5th Feb 2016",
            cost: 50,
            rider_id: "RD0003",
            rating: 2
        }
    ],
    DR0004: [
        {
            date: "3rd Feb 2016",
            cost: 5,
            rider_id: "RD0022",
            rating: 5
        },
        {
            date: "4th Feb 2016",
            cost: 10,
            rider_id: "RD0022",
            rating: 4
        },
        {
            date: "5th Feb 2016",
            cost: 20,
            rider_id: "RD0073",
            rating: 5
        }
    ]
}

########################################################
# Step 4: Total Driver's Earnings and Number of Rides
def line
  puts "########################################################"
end

# # the number of rides each driver has given -----------------------------------
# def num_of_rides_method(driver_id, drivers_hash)
#   return (drivers_hash[driver_id]).length
# end
# line

# the total amount of money each driver has made -----------------------------------
def income_method(rides_array)
  return rides_array.reduce(0) { |sum, ride_hash| sum + ride_hash[:cost] }
end

# the average rating for each driver -----------------------------------

def average_rating_method(rides_array, num_of_rides)
  sum_ratings = rides_array.reduce(0) { |sum, ride_hash|
    sum + ride_hash[:rating] }
  return (sum_ratings / num_of_rides.to_f).round(1) # why can't this be included in the reduce block?
end

# Which driver made the most money? -----------------------------------
# this returns the first value, does not handle ties.
def highest_income_method(tallies_array_of_hashes)
  return tallies_array_of_hashes.max_by { |tally_hash| tally_hash[:income] }[:driver_id]
end

# Which driver has the highest average rating? -----------------------------------
# this returns the first value, does not handle ties.
def highest_average_rating_method(tallies_array_of_hashes)
  return tallies_array_of_hashes.max_by { |tally_hash| tally_hash[:average_rating] }[:driver_id]
end

# For each driver, on which day did they make the most money? -----------------------------------
def date_highest_income_method(rides_array)
  rides_array.max_by { |ride_hash| ride_hash[:cost] }[:date]
end

# runs all the methods -----------------------------------
def summary(drivers_hash)
  tallies_array_of_hashes = Array.new
  drivers_hash.each do |driver_id, rides_array|

    num_of_rides = (drivers_hash[driver_id]).length
    income = income_method(rides_array)
    average_rating = average_rating_method(rides_array, num_of_rides)
    date_highest_income = date_highest_income_method(rides_array)

    tallies_hash = {
        date_highest_income: date_highest_income,
        driver_id: driver_id,
        income: income,
        average_rating: average_rating
    }
    tallies_array_of_hashes << tallies_hash

    puts "Driver with id #{driver_id} gave #{num_of_rides} ride(s) and \
made $#{income}.
On average, their rating was #{average_rating} stars.
They made the most money on #{date_highest_income}."
    puts "------"
  end

  highest_income = highest_income_method(tallies_array_of_hashes)
  highest_average_rating = highest_average_rating_method(tallies_array_of_hashes)

  puts "Driver with id #{highest_income} made the most money."
  puts "Driver with id #{highest_average_rating} \
had the highest rating, on average."
end
summary(drivers_hash)
