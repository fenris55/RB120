#question 4

# class Greeting
#   def greet(message)
#     puts message
#   end
# end

# class Hello < Greeting
#   def hi
#     greet('hello')
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet('Goodbye')
#   end
# end

#question 5

# class KrispyKreme
#   attr_reader :filling_type, :glazing

#   def initialize(filling_type, glazing)
#     @filling_type = filling_type
#     @glazing = glazing
#   end

# #used a ternary but had to check solution for how to handle the nil correctly
#   def to_s
#     filling_type = @filling_type ? @filling_type : "Plain"
#     glazing = @glazing ? " with #{@glazing}" : ''
#     filling_type + glazing
#   end
# end

# donut1 = KrispyKreme.new(nil, nil)
# donut2 = KrispyKreme.new("Vanilla", nil)
# donut3 = KrispyKreme.new(nil, "sugar")
# donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
# donut5 = KrispyKreme.new("Custard", "icing")

# puts donut1
#   #=> "Plain"

# puts donut2
#   #=> "Vanilla"

# puts donut3
#   #=> "Plain with sugar"

# puts donut4
#   #=> "Plain with chocolate sprinkles"

# puts donut5
#   #=> "Custard with icing"
