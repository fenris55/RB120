=begin
# Inheritance: Lecture and OO Basics exercises
#1
class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog

  def swim
    "can't swim!"
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

butch = Bulldog.new
puts butch.speak
puts butch.swim

#2
# my solution:
class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Dog

  def swim
    "can't swim!"
  end

  def fetch
    "can't fetch"
  end
end

terra = Dog.new
puts terra.swim
puts terra.fetch

charles = Cat.new
puts charles.swim
puts charles.fetch

#lesson solution: places most methods into Pet superclass:

class Pet

  def run
    'running!'
  end

  def jump
    'jumping!'
  end

end

class Dog < Pet

  def speak
    "bark"
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end

end

class Cat < Pet
  def speak
    "meow"
  end
end

class Bulldog < Dog

  def swim
    "can't swim!"
  end
end

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

puts pete.run                # => "running!"
#puts pete.speak              # => NoMethodError

puts kitty.run               # => "running!"
puts kitty.speak             # => "meow!"
#puts kitty.fetch             # => NoMethodError

puts dave.speak              # => "bark!"

puts bud.run                 # => "running!"
puts bud.swim                # => "can't swim!"

#3: draw a class hierarchy diagram of the above classes
#note: lesson solution includes instances methods for each class

                                         #Dog -> Bulldog
#BasicObject -> Kernel -> Object -> Pet <
                                         #Cat

#4: What is method lookup path and why is it important?
The method lookup path is the order in which the interpreter searches for a method.
First it will check the class of the current instances. If no method of the given
name is found, it will then check the included modules (beginning with the last
and endig with the first) and will then continue checking the supclass of each
subclass. Finally if no method is found in BasicObject, it will output a NoMethod error.

#OOP Basics: Inheritance Exercises

#1
class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
end

class Car < Vehicle
end

truck1 = Truck.new(1994)
puts truck1.year

car1 = Car.new(2006)
puts car1.year

#2
class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle

  def initialize(year)
    super
    start_engine
  end

  def start_engine
    puts 'Ready to go!'
  end
end

truck1 = Truck.new(1994)
puts truck1.year

#3
class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle

  attr_reader :bed_type

  def initialize(year, bed_type)
    super(year)
    @bed_type = bed_type
  end

end

class Car < Vehicle
end

truck1 = Truck.new(1994, 'Short')
puts truck1.year
puts truck1.bed_type

#4
class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle

  def start_engine(speed)
    super() + " Drive #{speed} please!"
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')

#5
module Towable

  def tow
    puts "I can tow a trailer!"
  end

end

class Truck
  include Towable
end

class Car
end

truck1 = Truck.new
truck1.tow

#6
module Towable

  def tow
    'I can tow a trailer!'
  end

end

class Vehicle

  attr_reader :year

  def initialize(year)
    @year = year
  end

end

class Truck < Vehicle

  include Towable

end

class Car < Vehicle
end

truck1 = Truck.new(1994)
puts truck1.year
puts truck1.tow

car1 = Car.new(2006)
puts car1.year

#7: list the lookup path when executing Cat.color
Path: Cat -> Animal

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new('Black')
cat1.color

#8: list the lookup path
Path: Cat -> Animal -> Obect -> Kernel -> BasicObject : output NoMethod error
class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color

#9: List the lookup path
Path: Bird -> Flyable -> Animal

module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

bird1 = Bird.new('Red')
bird1.color

#10
=end

module Transportation

  class Vehicle
  end

  class Truck < Vehicle
  end

  class Car < Vehicle
  end

end