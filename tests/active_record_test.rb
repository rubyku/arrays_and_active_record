require "test/unit"
require 'ffaker'

require_relative "../support/active_record_support"

def create_car(options = {})
  options[:color]     ||=  Car::COLOR_ARRAY.sample
  options[:condition] ||=  Car::CONDITION_ARRAY.sample
  options[:top_speed] ||=  Car::SPEEDS_ARRAY.sample

  Car.create(:color     => options[:color],
             :condition => options[:condition],
             :top_speed => options[:top_speed])
end



class ActiveRecordTest < Test::Unit::TestCase

  # assign variable to a dealership with the same name
  def test_regular_where
    dealership = nil
    name = Faker::Company.name
    d    = Dealership.create(:name => name)
    # put your code here
    assert_equal d, dealership
  end


  # Group and count all the cars of a similar color
  # use the group and count methods, assign your output to the variable `color_group`
  def test_select
    color_group = {}
    color = "cheetah"
    cars = []
    3.times do
      cars << create_car(:color => color)
    end
    # put your code here
    assert_equal Car.where(:color => color).count, color_group[color]
  end


  # find all the dealerships with given id's
  def test_in
    dealerships = nil
    dealerz = 3.times.map { Dealership.create(:name => Faker::Company.name) }
    ids     = dealerz.map {|d| d.id}
    # put your code here
    assert_equal dealerz, dealerships
  end


  # Find all the cars of a given color in reverse order by created_at
  # using only SQL methods
  # assign to a variable reverse_cars
  # remember time is ever increasing in a positive direction, how do you want to order ASC or DESC?
  def test_order
    reverse_cars = []
    color = "gold cheetah"
    cars = 5.times.map {create_car(:color => color)}
    # put your code here
    assert_equal cars.reverse, reverse_cars
  end


  # find the first 4 cars of a given color assign to variable `limited_cars`
  def test_limit
    limited_cars = nil
    color = "silver cheetah"
    cars = 5.times.map {create_car(:color => color)}
    # put your code here
    assert_equal cars.first(4), limited_cars
  end

  # find the second and third cars of a given color, using offset and limit
  # assign to variable offset_cars
  def test_offset
    offset_cars = nil
    color = "mango magenta"
    cars = 5.times.map {create_car(:color => color)}
    # put your code here
    assert_equal cars[1,2], offset_cars
  end



  # find all dealerships that have a car of a given color, assign to a variable dealerships
  def test_joins
    dealerships = nil
    color = "corgie brown"
    dealerz = []
    3.times do
      d = Dealership.create(:name => Faker::Company.name)
      d.cars.create(:color => color)
      dealerz << d
    end
    # put your code here
    assert_equal dealerz, dealerships
  end




  # Use the #having operator to find all the dealerships that have cars of an average top speed of 5 or more
  # to get you started the join and group statements are included below, just
  # fill out the having
  def test_having
    dealerships = []
    dealerz = []
    color = "liger yellow"
    3.times do
      d = Dealership.create(:name => Faker::Company.name)
      d.cars.create(:color => color, :top_speed => 5)
      dealerz << d
    end
    d  = Dealership.create(:name => Faker::Company.name)
    d.cars.create(:color => color, :top_speed => 2)
    # put your code here
    dealerships = Dealership.joins(:cars).group("dealerships.id, cars.top_speed").having("")
    assert_equal dealerz, dealerships.all
  end

end
