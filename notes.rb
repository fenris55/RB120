#Book exercises

#1.1
# We create an object inRuby by defining a class and then calling the #new
# method on the class name. In order to use the object, we can initialize a
# local variable to reference the created object.

# class Mailbox
# end

#above, we have a definition for the custom class Mailbox. Currently the class
# definition is empty; instances created from this class have no behaviors or
# data associated with them

# mailbox = Mailbox.new

#here we create a new object of the Mailbox class by invoking the #new method
# on the Mailbox class name. We can also refer to this as instantiating a new
# instance of the Mailbox class. In order to work with the created instance,
# local variable `mailbox` has been initialized to reference the object.


# class HuntingDog
#   LEGS = 4
# end

# module Dog

#   class Golden < HuntingDog
#     def display_legs
#       LEGS
#     end
#   end
# end

# chet = Dog::Golden.new
# puts chet.display_legs
# puts Dog::Golden.ancestors

# module Describable
#   def describe_shape
#     "I am a #{self.class} and have #{SIDES} sides."
#   end
# end

# class Shape
#   include Describable

#   def self.sides
#     self::SIDES
#   end
# end

# class Quadrilateral < Shape
#   SIDES = 4
# end

# class Square < Quadrilateral; end

# puts Square.sides # => 4
# # Square.new.sides # => 4
# Square.new.describe_shape # => "I am a Square and have 4 sides."

# class Shape
#   @@sides = nil
#   def self.sides
#     @@sides
#   end

#   def sides
#     @@sides
#   end

# end

# class Triangle < Shape
#   def initialize
#     @@sides = 3
#   end
# end

# class Quadrilateral < Shape
#   def initialize
#     @@sides = 4
#   end
# end

# p Triangle.sides
# tri =  Triangle.new
# # p tri.sides
# p Triangle.sides
# quad = Quadrilateral.new
# p Triangle.sides

class AnimalClass
  attr_accessor :name, :animals

  def initialize(name)
    @name = name
    @animals = []
  end

  def <<(animal)
    animals << animal
  end

  def +(other_class)
    temp_animal_array = AnimalClass.new("Temp Animal Class")
    temp_animal_array.animals = animals + other_class.animals
    temp_animal_array
  end

  def to_s
   "#{animals}"
  end
end

class Animal
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end
end

mammals = AnimalClass.new('Mammals')
mammals << Animal.new('Human')
mammals << Animal.new('Dog')
mammals << Animal.new('Cat')

birds = AnimalClass.new('Birds')
birds << Animal.new('Eagle')
birds << Animal.new('Blue Jay')
birds << Animal.new('Penguin')

some_animal_classes = mammals + birds
# puts some_animal_classes

puts mammals

