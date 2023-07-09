#1.1
# How do we create an object? Give an example

#We create an object in Ruby by calling the #new method on the class name. The
#creation of a new object is also referred to as "instantiation." We
#can use either a built in class that comes with Ruby or define a custom class.
#below, I'll define a custom class and then create, or instantiate, a new object
#from that class.

# class TestClass
# end

# example = TestClass.new

#1.2
#What is a module? What is its purpose? How do we use them with our classes?
#Create a module for the class created above and include it correctly.

# A module is a container for data. In Ruby, modules have 2 purposes:
# for namespacing and as method containers. In namespacing, modules are used to
# hold class definitions that should logivcally be grouped together. Namespacing
#protects against the unintentional effects of having multiple classes with
#the same class name, which is a concern in larger, more complex programs.

#When modules are used as method containers, they hold method definitions that
# are logically grouped together and 2. modules are used as method containers
#either becuase the methods defined inside will be used by multiple classes, so
#the code can be less repetetive, or because they'll be used by only one class,
#but their presence within the class definition makes the class difficult to
# read, and they can be logically extracted to a separate container.

#modules are included in a class using the `include` method invocation followed by
#the module name. A modules that has been included in a class definiiton is also
#referred to as a "mixin". In Ruby, there is no limit to the number of modules
#that can #be included in a class definition, and no limit to the number of
#classes that a single module can be mixed in to.

#below is the class definition from the previous exercise. Additionally, the
#module `TestModule` has been included in the `TestClass` class. `TestModule`
#contains one module, `#module_method`. Now instances of the TestClass class
#have access to the #module_method` method. This is demonstrated by class the
#module_method method on the instance of the TestClass referenced by local
#variable `example`

#NOTE: INCLUDE IS A METHOD

# module TestModule
#   def module_method
#     puts "Printing from the the module!"
#   end
# end

# class TestClass
#   include TestModule
# end

# example = TestClass.new
# example.module_method

#2.1

#create a MyCar class with year color and model initialized at instantiation
#(user input) as well as speed initilaized to 0. Create instance methods to
#speed up, brake, and shut off car.

# add an accessor methods to view and change color and to only view year

#create a #spray_paint method that modifies car color

# class MyCar
#   attr_accessor :color
#   attr_reader :year

#   def initialize(year, color, model)
#     @year = year
#     @color = color
#     @model = model
#     @speed = 0
#   end

#   def speed_up(speed_increase)
#     @speed += speed_increase
#   end

#   def brake(speed_decrease)
#     @speed -= speed_decrease
#   end

#   def shut_off
#     @speed = 0
#   end

#   def spray_paint(new_color)
#     self.color = new_color
#   end
# end

# my_car = MyCar.new(2015, 'white', 'Q5')
# # puts my_car.year
# # puts my_car.color
# # puts my_car.model
# # puts my_car.speed
# # puts my_car.speed_up(70)
# # puts my_car.brake(20)
# # puts my_car.shut_off
# puts my_car.color
# # puts my_car.color = 'black'
# # puts my_car.color=('black')
# # puts my_car.color
# # puts my_car.year
# my_car.spray_paint('purple')
# puts my_car.color

#3.1

#add a class method to the MyCar class that calculates the gas mileage of any car

#3.2
#override the #to_s method

# class MyCar
#   attr_accessor :color
#   attr_reader :year, :model

#   def initialize(year, color, model)
#     @year = year
#     @color = color
#     @model = model
#     @speed = 0
#   end

#   def self.calculate_mileage(gallons, miles)
#     miles_per_gallon = miles / gallons
#     puts "Your gas mileage is: #{miles_per_gallon}."
#   end

#   def speed_up(speed_increase)
#     @speed += speed_increase
#   end

#   def brake(speed_decrease)
#     @speed -= speed_decrease
#   end

#   def shut_off
#     @speed = 0
#   end

#   def spray_paint(new_color)
#     self.color = new_color
#   end

#   def to_s
#     "Your car is a #{color} #{year} #{model}."
#   end
# end

# # MyCar.calculate_mileage(20, 120)
# audi = MyCar.new(2015, 'white', 'Q5')
# puts audi

#3.3
#Explain the error
# We receive a undefined method error because the class definition does not
# contain a setter method. This should be fixed by changing the attr_reader
#setter method to attr_accessor, which serves as a combined getter and setter
#method. We could also leave the getter method as it appears in the code and
#manually write the setter method, like so:

#NOTE: here, we must access the instance variable directly using by prepending
# the @. Attempting to call self.name= within the setter method will result
# in a recursive loop, as the program will go search for a method by that
# name, locate and execute itself, and continue in this loop until stack
# volume is exceeded.

# def name=(name)
#   @name = name
# end

#4.1 - 4.6

#Create a Vehicle superclass and extract logic from MyCar:
# module Loadable
#   def load
#     puts "I can carry a load."
#   end
# end

# class Vehicle
#   @@number_of_vehicles = 0
#   attr_accessor :color
#   attr_reader :year, :model

#   def initialize(year, color, model)
#     @year = year
#     @color = color
#     @model = model
#     @speed = 0
#     @@number_of_vehicles +=1
#   end

#   def self.calculate_mileage(gallons, miles)
#     miles_per_gallon = miles / gallons
#     puts "Your gas mileage is: #{miles_per_gallon}."
#   end

#   def speed_up(speed_increase)
#     @speed += speed_increase
#   end

#   def brake(speed_decrease)
#     @speed -= speed_decrease
#   end

#   def shut_off
#     @speed = 0
#   end

#   def spray_paint(new_color)
#     self.color = new_color
#   end

#   def self.display_vehicle_count
#     puts "#{@@number_of_vehicles} vehicles have been created."
#   end

#   def age
#     puts "Your vehicle is #{calculate_age} years old."
#   end

#   private

#   def calculate_age
#     new_time = Time.new
#     new_time.year - self.year
#   end
# end

# class MyCar < Vehicle
#   PASSENGER_CAPACITY = 5

#   def to_s
#     "Your car is a #{color} #{year} #{model}."
#   end
# end

# class MyTruck < Vehicle
#   include Loadable
#   PASSENGER_CAPACITY = 2

#   def to_s
#     "Your truck is a #{color} #{year} #{model}."
#   end
# end

# truck = MyTruck.new(2018, 'black', 'Ford Tundra')
# car = MyCar.new(2015, 'white', 'Audi Q5')

# puts truck
# puts car
# Vehicle.display_vehicle_count

# truck.load
# car.load # should return error

# puts Vehicle.ancestors
# puts '---------------------'
# puts MyCar.ancestors
# puts '---------------------'
# puts MyTruck.ancestors

# truck.age
# car.age

#4.7

# class Student
#   attr_reader :name

#   def initialize(name, grade)
#     @name = name
#     @grade = grade
#   end

#   def better_grade_than?(other_student)
#   grade > other_student.grade
#   end

#   protected

#   attr_reader :grade
# end

# joe = Student.new('Joe', 87)
# puts joe.name
# #puts joe.grade # raises error
# rob = Student.new('Rob', 97)
# puts rob.name

# puts "Well done!" if rob.better_grade_than?(joe) #eturns true
# # puts joe.better_grade_than?(rob) #returns false

#4.8
#The problem is that #hi is a private method, and is not availble to the main
#code base. This can be solved by changing the method access control to make #hi
# public (ie, placing it above the protected and private access control modifiers
# in the class definition). Alternatively, the code could be left as-is, and
# a new public method could be defined to call hi. However, this approach would
# require changing the given code, as the new public method would need to be
# called instead of #hi:

# class Person
#   def display_greeting
#     hi
#   end

#   private

#   def hi
#     #some code
#   end
# end