=begin
#OOP Basics exercises: accessor methods

#1
class Person
  attr_accessor :name
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name

#2
class Person
  attr_accessor :name
  attr_writer :phone_number
end

person1 = Person.new
person1.name = 'Jessica'
person1.phone_number = '0123456789'
puts person1.name

#3
class Person
  attr_reader :phone_number

  def initialize(number)
    @phone_number = number
  end
end

person1 = Person.new(1234567899)
puts person1.phone_number

person1.phone_number = 9987654321
puts person1.phone_number

#4
class Person
  attr_accessor :first_name
  attr_writer :last_name

  def first_equals_last?
    first_name == last_name
  end

  private

  attr_reader :last_name

end

person1 = Person.new
person1.first_name = 'Dave'
person1.last_name = 'Smith'
puts person1.first_equals_last?

#5
class Person
  attr_writer :age

  def older_than?(other)
    age > other.age
  end

  protected

  attr_reader :age
end

person1 = Person.new
person1.age = 17

person2 = Person.new
person2.age = 26

puts person1.older_than?(person2)

#6
class Person
  attr_reader :name

  def name=(name)
    @name = name.capitalize
  end
end

person1 = Person.new
person1.name = 'eLiZaBeTh'
puts person1.name

#7
class Person
  attr_writer :name
 # attr_reader :name

  # def name=(name)
  #   @name = "Mr. #{name}"
  # end

  #lesson uses just an instance method, not a setter and reverses accessor:
  #NOT a setter - it's a getter with added functionality
  def name
    "Mr. #{@name}"
  end
end

person1 = Person.new
person1.name = 'James'
puts person1.name

#8
class Person
#  attr_reader :name

  def initialize(name)
    @name = name
  end

#Knew I needed to disable the attr_reader and manually define a getter method
#that returns a copy of name; wasn't sure how to achieve that more directly so split
#it into an array and then rejoined. Solution just uses #clone:

#the call to person1.name now returns a copy, but that copy has not been mutated
#- because it returns a new copy each time it's called and the mutated copy is
# never saved/reassigned?

  def name
  #  @name.split.join
  @name.clone
  end

end

person1 = Person.new('James')
puts person1.name.reverse!
puts person1.name

#9
class Person

  def age
    @age * 2
  end

  def age=(age)
    @age = age * 2
  end

end

#lesson solution also demonstrates how to double only once by placing that
#functionality into a private instance method:

class Person

  def age
    double_number(@age)
  end

  def age=(age)
    @age = double_number(age)
  end

  private

  def double_number(value)
    value * 2
  end

end
person1 = Person.new
person1.age = 20
puts person1.age

#10
=end

class Person

  def name
    "#{@first_name} #{@last_name}".strip
  end

  def name=(name)
    #lesson solution uses multiple assignment (and assumes the input string will
    #always include 2 names):

    # did not know multiple assignment works with split this way:
    @first_name, @last_name = name.split

    # names = name.split
    # @first_name = names.first
    # @last_name = names.size > 1 ? names.last : ''
  end

end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name