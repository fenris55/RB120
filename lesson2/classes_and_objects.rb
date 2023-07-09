=begin
### Contains exercises from lecture on classes and objects
### AND small problems classes and objects 1 and 2

Lecture: Classes and Objects

1 - write the class definition code

class Person

  attr_accessor :name

  def initialize(name)
    @name = name
  end

end

bob = Person.new('bob')
p bob.name                  # => 'bob'
bob.name = 'Robert'
p bob.name                  # => 'Robert'

#2 - modify the above class to the given code

#my solution:
class Person

  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name='')
    @first_name = first_name
    @last_name = last_name
  end

  def name
    @name = "#{@first_name} #{@last_name}".strip
  end
end

#lesson solution: (initialize is handled differently)
class Person

  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end

  def name
    "#{@first_name} #{@last_name}".strip
  end

end
bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

#3 write a name= method that can take either a full name or first name and set them correctly
#lesson solution

class Person

  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{@first_name} #{@last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end

  def to_s
    name
  end

end

bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
# p bob.first_name            # => 'John'
# p bob.last_name             # => 'Adams'
# p bob.name

#4 - create 2 new instances
bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
#show how to find whetehr bob and rob contain the same name
# p bob.name
# p rob.name
# p bob == rob
# p bob.name == rob.name

#5 what does the following code print?
# should output - the instance id/numbers?(note: PLACE IN MEMORY) would need to interpolate bob.name? -> yes

bob = Person.new("Robert Smith")
# puts "The person's name is: #{bob.name}"
puts "The person's name is: #{bob}"
#with added to_s method, should output name. The added to_s method invokes the name
#instance method, which returns the full name interpolated in a string


### Small Problems
# Classes and Object 1

#1: update the code to print the class
puts "Hello".class
puts 5.class
puts [1, 2, 3].class


#2 create an empty class Cat
#3 create an instance of Cat and assign it to a variable named kitty
#4 add an initialize method that prints 'I'm a cat'
#5-#9

class Cat

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  # def name
  #   @name
  # end

  # def name=(name)
  #   @name = name
  # end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.name = 'Luna'
kitty.greet

#10
module Walkable

  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.walk

### Classes and Objects 2
#1 - #2

class Cat

  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end

end

Cat.generic_greeting
kitty = Cat.new
kitty.class.generic_greeting


class Cat

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(new_name)
    self.name = new_name
  end

end

kitty = Cat.new('Sophie')
puts kitty.name
kitty.rename('Chloe')
puts kitty.name

#4
class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def identify
    self
  end
end

kitty = Cat.new('Sophie')
p kitty.identify

#5
class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.generic_greeting
    puts "Hello, I'm a cat!"
  end

  def personal_greeting
    puts "Hello! I'm #{@name}!"
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting

#6
class Cat

  @@count = 0

  def initialize
    @@count += 1
  end

  def self.total
   puts @@count
  end
end

kitty1 = Cat.new
kitty2 = Cat.new

Cat.total

#7
class Cat

  COLOR = 'purple'

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{@name} and I'm a #{COLOR} cat!"
  end

end

kitty = Cat.new('Sophie')
kitty.greet

#8
class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "I'm #{@name}!"
  end
end

kitty = Cat.new('Sophie')
puts kitty

#9
class Person

  # attr_accessor :secret

  def initialize
    @secret = ''
  end

  def secret
    @secret
  end

  def secret=(new_secret)
    @secret = new_secret
  end
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
puts person1.secret

#10
class Person
  attr_writer :secret

  def share_secret
    puts  @secret
  end

  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
person1.share_secret

#11

class Person
  attr_writer :secret

  def compare_secret(other)
   # @secret == other.secret
    self.secret == other.secret
  end

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)


Second Pass
#1
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

bob = Person.new('bob')
puts bob.name                  # => 'bob'
bob.name = 'Robert'
puts bob.name                  # => 'Robert'

#2 - 4
=end

# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(name)
#     split_name(name)
#   end

#   def name
#     "#{first_name} #{last_name}"
#   end

#   def name=(name)
#     split_name(name)
#   end

#   def same_name?(other)
#     name == other.name
#   end

#   private

#   def split_name(name)
#     @first_name, @last_name = name.split(' ')
#   end
# end

# bob = Person.new('Robert Smith')
# rob = Person.new('Robert Smith')
# puts bob.same_name?(rob)
# puts bob.name == rob.name
# bob = Person.new('Robert')
# puts bob.name                  # => 'Robert'
# puts bob.first_name            # => 'Robert'
# puts bob.last_name             # => ''
# bob.last_name = 'Smith'
# puts bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# puts bob.first_name            # => 'John'
# puts bob.last_name             # => 'Adams'

#5
#Attempting to interpolating the variable referecing a custom object into a
#string with output the entire object, if the class number followed by the
#encoded located in memory. To fix this code, we can either override #to_s
#and create a custom #to_s method that returns just the value associated with
#the #name instance variable, or we can call the #name getter method on the
#instance referenced by `bob`, interpolating the name directly.















