#OOP exercises - Debuggnig and Medium 2

# class Animal
#   def initialize(diet, superpower)
#     @diet = diet
#     @superpower = superpower
#   end

#   def move
#     puts "I'm moving!"
#   end

#   def superpower
#     puts "I can #{@superpower}!"
#   end
# end

# class Fish < Animal
#   def move
#     puts "I'm swimming!"
#   end
# end

# class Bird < Animal
# end

# class FlightlessBird < Bird
#   def initialize(diet, superpower)
#     super
#   end

#   def move
#     puts "I'm running!"
#   end
# end

# class SongBird < Bird
#   def initialize(diet, superpower, song)
#     super
#     @song = song
#   end

#   def move
#     puts "I'm flying!"
#   end
# end

#Fixing code: add getter method for diet

# Examples

# 1.
# unicornfish = Fish.new(:herbivore, 'breathe underwater')
# puts unicornfish #object- yes
# p unicornfish #object with no attributes - no; attribute are present
# puts unicornfish.move # "I'm swimming" -yes
# puts unicornfish.superpower # error -> no name error? - no; code works
#note: if the constructor were fixed, there would still be an error because
#there is no getter method


#guess: Fish class does not have a constructor method, so there's no way to
#pass the arguments up to the super class - fish will be instantiated, but the
#attributes will remain set to nil. Move can be called but superpower can not
#be called

##MENTAL MODEL REFINING:
# totally wrong.
#POINT 1: the arguments do pass to super even without an intermediary
# constructor.
#Point 2: Since the instance variable has been initialized, it
# appears in the string because it exists and is being called using string
# interpolation of the instance variable name; would not work if the @ were
#removed, since then it would be calling a non-existent getter method

#ACTUALLY rethinking that -> is superpower the getter method? and it's just
#formatting how @superower will be returned?

# penguin = FlightlessBird.new(:carnivore, 'drink sea water')
# puts penguin #object
# p penguin #object with attributes
# puts penguin.move #I'm walking
# puts penguin.superpower #I can drink sea water
# puts penguin.diet ## this will not work - no getter method -> no method error

#only difference here is that the FlightlessBird class has a constructor that
#passes the arguments to super. Based on the last example, this is unneccesary;
# expect all output to work. But, attmepting to call diet will since, since there
# is no getter (did not test that with first example)

# robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')
# puts robin
# p robin
# puts robin.move
# puts robin.superpower
# puts robin.diet
#this one is a little different -> Songbird and Animal have constructor methods.
#but the intermediate class Bird does not. Based on the other example I expect
#to see the same behavior with all method calls. Confused why the problems says
#this code raises an exception.

#Ooh was not looking closely enough. The Songbird constructore needs to pass
#just the first 2 arguemtns to super. Currently all 3 are being automatically
# passed, which raises an Arguemtn Error for the wrong number of argumetns

#3
# class Person
#   attr_reader :name
#   attr_accessor :location

#   def initialize(name)
#     @name = name
#   end

#   def teleport_to(latitude, longitude)
#     @location = GeoLocation.new(latitude, longitude)
#   end
# end

# class GeoLocation
#   attr_reader :latitude, :longitude

#   def initialize(latitude, longitude)
#     @latitude = latitude
#     @longitude = longitude
#   end

#   def to_s
#     "(#{latitude}, #{longitude})"
#   end

#   #testing:
#   def ==(other)
#     latitude == other.latitude && longitude == other.longitude
#   end
# end

# # Example

# ada = Person.new('Ada')
# ada.location = GeoLocation.new(53.477, -2.236)

# grace = Person.new('Grace')
# grace.location = GeoLocation.new(-33.89, 151.277)

# ada.teleport_to(-33.89, 151.277)

# puts ada.location                   # (-33.89, 151.277)
# puts grace.location                 # (-33.89, 151.277)
# puts ada.location == grace.location # expected: true
#                                     # actual: false
# puts ada.location.latitude == grace.location.latitude && ada.location.longitude == grace.location.longitude
#returning false because the Person class location getter method is returning
#the value referenced by instance variable @location, which is a GeoLocation
#object. Grace and Ada each have a @location instance variable, which references
# two different GeoLocation objects that currently have the same values stored
# in their @latitude and @longitude instance variable.

#Options:
#could call ada.location.latitude == grace.location.latitude &&
#  ada.location.longitude == grace.location.longitude

# i think this is the only way to compare that these values are the same while
#leaving the functionality the same. Otherwise would have to rely on a call
# variable that would keep getting reassigned - which would requires that all
# instances (of both Person and GeoLocation have only one shared location)

#additional thoughts -- could we redefine the GeoLocation == method? probably, but then
# its functionality would be pretty narrow

# #4
# class EmployeeManagementSystem
#   attr_reader :employer

#   def initialize(employer)
#     @employer = employer
#     @employees = []
#   end

#   def add(employee)
#     if exists?(employee)
#       puts "Employee serial number is already in the system."
#     else
#       employees.push(employee)
#       puts "Employee added."
#     end
#   end

#   alias_method :<<, :add

#   def remove(employee)
#     if !exists?(employee)
#       puts "Employee serial number is not in the system."
#     else
#       employees.delete(employee)
#       puts "Employee deleted."
#     end
#   end

#   def exists?(employee)
#     employees.any? { |e| e == employee }
#   end

#   def display_all_employees
#     puts "#{employer} Employees: "

#     employees.each do |employee|
#       puts ""
#       puts employee.to_s
#     end
#   end

#   private

#   attr_accessor :employees
# end

# class Employee
#   attr_reader :name

#   def initialize(name, serial_number)
#     @name = name
#     @serial_number = serial_number
#   end

#   def ==(other)
#     serial_number == other.serial_number
#   end

#   def to_s
#     "Name: #{name}\n" +
#     "Serial No: #{abbreviated_serial_number}"
#   end

#   protected

#   attr_reader :serial_number

#   private

#   def abbreviated_serial_number
#     serial_number[-4..-1]
#   end
# end

# # Example

# miller_contracting = EmployeeManagementSystem.new('Miller Contracting')

# becca = Employee.new('Becca', '232-4437-1932')
# raul = Employee.new('Raul', '399-1007-4242')
# natasha = Employee.new('Natasha', '399-1007-4242')

# miller_contracting << becca     # => Employee added.
# miller_contracting << raul      # => Employee added.
# miller_contracting << raul      # => Employee serial number is already in the system.
# miller_contracting << natasha   # => Employee serial number is already in the system.
# miller_contracting.remove(raul) # => Employee deleted.
# miller_contracting.add(natasha) # => Employee added.

# miller_contracting.display_all_employees

# #Guess: when the first employer (becca) is added, the employee array will be
# #empty, so I think the custom == will never execute and becca will get added
# #after that, it will output an error becuase the custom == is used to compare
# #employee serial numbers every time an employee is added. However, the serial
# #number getter method is set to private, making it visible only within its own
# #instance. To compare serial numbers of two different Employee objects, the
# # attr_reader for serial number should be set to protected

# ##VICTORY. Becca was added.

# #5
# class File
#   attr_accessor :name, :byte_content

#   def initialize(name)
#     @name = name
#   end

#   alias_method :read,  :byte_content
#   alias_method :write, :byte_content=

#   def copy(target_file_name)
#     target_file = self.class.new(target_file_name)
#     target_file.write(read) #reassinging byte_content to byte_content but what is byte_content??

#     target_file
#   end

#   def to_s
#     "#{name}.#{self.class::FORMAT}" # change to self.class::FORMAT ??
#   end
# end

# class MarkdownFile < File
#   FORMAT = :md
# end

# class VectorGraphicsFile < File
#   FORMAT = :svg
# end

# class MP3File < File
#   FORMAT = :mp3
# end

# # Test

# blog_post = MarkdownFile.new('Adventures_in_OOP_Land') #@name is arg
# blog_post.write('Content will be added soon!'.bytes)
# #write is an alias for the byte_contetn setter method. Current byte_content
# is nil, but this lne initilaizes it to the string argument BUT Idk what
# .bytes is doing -- looks like a mathod being called on the string argument
#(which could pass in a return value instead of the string itself, BUT -- ok.)

#bytes is actaully a method. from docs: String#bytes is a string method returning
# an array of bytes for a given string.

#SO the string argement is being converted to an array of bytes and THAT is being
# assigned to the @byte_content instance variable

# copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')
# #creating a copy. New MarkdownFil instance, new name, same byte_content

# puts copy_of_blog_post.is_a? MarkdownFile     # true ## should return and then output true
# puts copy_of_blog_post.read == blog_post.read # true ## again, these are method calls
# #both have the same byte content, so they are equal and return true

# puts blog_post # -> error; no initialized constant
#try resolving by calling self.class::FORMAT
#using the constant resoltuion operator to located the constant in the correct class

#6
# class Length
#   attr_reader :value, :unit

#   def initialize(value, unit)
#     @value = value
#     @unit = unit
#   end

#   def as_kilometers
#     convert_to(:km, { km: 1, mi: 0.6213711, nmi: 0.539957 })
#   end

#   def as_miles
#     convert_to(:mi, { km: 1.609344, mi: 1, nmi: 0.8689762419 })
#   end

#   def as_nautical_miles
#     convert_to(:nmi, { km: 1.8519993, mi: 1.15078, nmi: 1 })
#   end

#   def <=>(other)
#     case unit
#     when :km  then value <=> other.as_kilometers.value
#     when :mi  then value <=> other.as_miles.value
#     when :nmi then value <=> other.as_nautical_miles.value
#     end
#   end

#   def ==(other)
#     case unit
#     when :km  then value == other.as_kilometers.value
#     when :mi  then value == other.as_miles.value
#     when :nmi then value == other.as_nautical_miles.value
#     end
#   end

#   def <(other)
#     case unit
#     when :km  then value < other.as_kilometers.value
#     when :mi  then value < other.as_miles.value
#     when :nmi then value < other.as_nautical_miles.value
#     end
#   end

#   def <=(other)
#     self < other || self == other
#   end

#   def >(other)
#     !(self <= other)
#   end

#   def >=(other)
#     self > other || self == other
#   end

#   def to_s
#     "#{value} #{unit}"
#   end

#   private

#   def convert_to(target_unit, conversion_factors)
#     Length.new((value / conversion_factors[unit]).round(4), target_unit)
#   end
# end

# # Example

# puts [Length.new(1, :mi), Length.new(1, :nmi), Length.new(1, :km)].sort
# => comparison of Length with Length failed (ArgumentError)
# expected output:
# 1 km
# 1 mi
# 1 nmi

# Example
# example = Length.new(4, :mi)
# example2 = Length.new(7, :km)

# => comparison of Length with Length failed (ArgumentError)
# expected output:
# 1 km
# 1 mi
# 1 nmi


 # first attempt (same as solution): not working
  # def <=>(other)
  #   case unit
  #   when :km then value <=> other.as_kilometers.value
  #   when :mi then value <=> other.as_miles.value
  #   when :nmi then value <=> other.as_nautical_miles.value
  #   end
  # end

  # not working. also tried this, also not working:
  # def <=>(other)
  #   return -1 if self < other
  #   return 0 if self == other
  #   return 1 if self > other
  # end

  # 3rd attempt also not working. gives the following error:
  # `/': nil can't be coerced into Integer (TypeError)
  # (/ references division from convert_to method)

  # def <=>(other)
  #   if self < other
  #     return -1
  #   elsif self == other
  #     return 0
  #   elsif self > other
  #     return 1
  #   end
  # end
#Problem: .sort uses <=> to sot by ASCII values. We need to create a custom
#<=> method and instruct it how to compare and sort Length objects. I guess it
#dosn't really matter which unit is used, as long as they are normalized?
# No. output is returning value and unit only, so <=> needs to compare 2 at a time
#so --use a case statement with convert like in the examples?

#NOTES: had the <=> method definition right, but tried a few different attempts
# at implementation couldn't get it to evaluate correctly

#7
# class BankAccount
#   attr_reader :balance

#   def initialize(account_number, client)
#     @account_number = account_number
#     @client = client
#     @balance = 0
#   end

#   def deposit(amount)
#     if amount > 0
#       self.balance += amount
#       "$#{amount} deposited. Total balance is $#{balance}."
#     else
#       "Invalid. Enter a positive amount."
#     end
#   end

#   def withdraw(amount)
#     if amount > 0
#       valid_transaction?(balance - amount) ? success = true : success = false

#       balance = (self.balance - amount)
#       #first attempt below. Then refactored above to use custom valid_transaction? method
#       #both work

#       # if (self.balance -= amount) > 0
#       #   (self.balance -= amount)
#       #   success = true
#       # else
#       #   false
#       # end

#     if success
#       "$#{amount} withdrawn. Total balance is $#{balance}."
#     else
#       "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
#     end
#     end
#   end

# #note: the original code is commented out because it doesn't worl
# #setter methods always return the argument, so this will always return new_balance
# #and never return false. A setter method's job should be to only reassign
#   def balance=(new_balance)
#     # if valid_transaction?(new_balance)
#       @balance = new_balance
#     #   true
#     # else
#     #   false
#     # end
#   end

#   def valid_transaction?(new_balance)
#     new_balance >= 0
#   end
# end

# # Example

# account = BankAccount.new('5538898', 'Genevieve')

#                           # Expected output:
# p account.balance         # => 0
# p account.deposit(50)     # => $50 deposited. Total balance is $50.
# p account.balance         # => 50
# p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
#                           # Actual output: $80 withdrawn. Total balance is $50.
# p account.balance         # => 50

#Overdraft protection is not working because the withdraw method allows any
#amount greater than 0 to be withdrawn. It should first check that amount is
#greater than 0, and then should check that subtracting new_balance from balance
#if also greater than z. that boolean should be set to success.

#8
# class TaskManager
#   attr_reader :owner
#   attr_accessor :tasks

#   def initialize(owner)
#     @owner = owner
#     @tasks = []
#   end

#   def add_task(name, priority=:normal)
#     task = Task.new(name, priority)
#     tasks.push(task)
#   end

#   def complete_task(task_name)
#     completed_task = nil

#     tasks.each do |task|
#       completed_task = task if task.name == task_name
#     end

#     if completed_task
#       tasks.delete(completed_task)
#       puts "Task '#{completed_task.name}' complete! Removed from list."
#     else
#       puts "Task not found."
#     end
#   end

#   def display_all_tasks
#     display(tasks)
#   end

#   def display_high_priority_tasks
#     tasks = tasks.select do |task|
#       task.priority == :high
#     end

#     display(tasks)
#   end

#   private

#   def display(tasks)
#     puts "--------"
#     tasks.each do |task|
#       puts task
#     end
#     puts "--------"
#   end
# end

# class Task
#   attr_accessor :name, :priority

#   def initialize(name, priority=:normal)
#     @name = name
#     @priority = priority
#   end

#   def to_s
#     "[" + sprintf("%-6s", priority) + "] #{name}"
#   end
# end

# valentinas_tasks = TaskManager.new('Valentina')

# valentinas_tasks.add_task('pay bills', :high)
# valentinas_tasks.add_task('read OOP book')
# valentinas_tasks.add_task('practice Ruby')
# valentinas_tasks.add_task('run 5k', :low)

# valentinas_tasks.complete_task('read OOP book')

# valentinas_tasks.display_all_tasks
# valentinas_tasks.display_high_priority_tasks

#9
# class Mail
#   def to_s
#     "#{self.class}"
#   end
# end

# class Email < Mail
#   attr_accessor :subject, :body

#   def initialize(subject, body)
#     @subject = subject
#     @body = body
#   end
# end

# class Postcard < Mail
#   attr_reader :text

#   def initialize(text)
#     @text = text
#   end
# end

# module Mailing
#   def receive(mail, sender)
#     mailbox << mail unless reject?(sender)
#   end

#   # Change if there are sources you want to block.
#   def reject?(sender)
#     false
#   end

#   def send_mail(destination, mail)
#     "Sending #{mail} from #{name} to: #{destination}"
#     # Omitting the actual sending.
#   end
# end

# class CommunicationsProvider
#   attr_reader :name, :account_number

#   def initialize(name, account_number=nil)
#     @name = name
#     @account_number = account_number
#   end
# end

# class EmailService < CommunicationsProvider
#   include Mailing

#   attr_accessor :email_address, :mailbox

#   def initialize(name, account_number, email_address)
#     super(name, account_number)
#     @email_address = email_address
#     @mailbox = []
#   end

#   def empty_inbox
#     self.mailbox = []
#   end
# end

# class TelephoneService < CommunicationsProvider
#   def initialize(name, account_number, phone_number)
#     super(name, account_number)
#     @phone_number = phone_number
#   end
# end

# class PostalService < CommunicationsProvider
#   include Mailing

#   attr_accessor :street_address, :mailbox

#   def initialize(name, street_address)
#     super(name)
#     @street_address = street_address
#     @mailbox = []
#   end

#   def change_address(new_address)
#     self.street_address = new_address
#   end
# end

# rafaels_email_account = EmailService.new('Rafael', 111, 'Rafael@example.com')
# johns_phone_service   = TelephoneService.new('John', 122, '555-232-1121')
# johns_postal_service  = PostalService.new('John', '47 Sunshine Ave.')
# ellens_postal_service = PostalService.new('Ellen', '860 Blackbird Ln.')

# puts johns_postal_service.send_mail(ellens_postal_service.street_address, Postcard.new('Greetings from Silicon Valley!'))
# => undefined method `860 Blackbird Ln.' for #<PostalService:0x00005571b4aaebe8> (NoMethodError)

#10
# class AuthenticationError < Exception; end
# class AuthenticationError < Error; end # shuld inherit from Error, not Exception

# # A mock search engine
# # that returns a random number instead of an actual count.
# class SearchEngine
#   def self.count(query, api_key)
#     if valid?(api_key)
#       return rand(200_000)
#     else
#       raise AuthenticationError, 'API key is not valid.'
#     end
#     # unless valid?(api_key)
#     #   raise AuthenticationError, 'API key is not valid.'
#     # end

#     # rand(200_000)
#   end

#   private

#   def self.valid?(key)
#     key == 'LS1A'
#   end
# end

# module DoesItRock
#   API_KEY = 'LS1A'

#   class NoScore; end

#   class Score
#     def self.for_term(term)
#       positive = SearchEngine.count(%{"#{term} rocks"}, 'test')
#       negative = SearchEngine.count(%{"#{term} is not fun"}, 'test2')

#       (positive * 100) / (positive + negative)

#     # rescue Exception
#     #   NoScore
#       rescue ZeroDivisionError #only want to rescue errors related to dividing by 0
#         NoScore.new
#     end
#   end

#   def self.find_out(term)
#     score = Score.for_term(term)

#     case score
#     when NoScore
#       "No idea about #{term}..."
#     when 0...40
#       "#{term} is not fun."
#     when 40...60
#       "#{term} seems to be ok..."
#     else
#       "#{term} rocks!"
#     end
#   # rescue Exception => e
#     rescue Error => e #outputting Error message (not Exception message)
#     e.message
#   end
# end

# # Example (your output may differ)

# puts DoesItRock.find_out('Sushi')       # Sushi seems to be ok...
# puts DoesItRock.find_out('Rain')        # Rain is not fun.
# puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!

#retrying Debugging #7

class BankAccount
  attr_reader :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if valid_transaction?(amount) #amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    new_balance = balance - amount

    if valid_transaction?(new_balance) #amount > 0
      self.balance -= amount
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  def balance=(new_balance)
    @balance = new_balance
    # if valid_transaction?(new_balance)
    #   @balance = new_balance
    #   true
    # else
    #   false
    # end
  end

  def valid_transaction?(amount)
    amount >= 0
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
                          # Actual output: $80 withdrawn. Total balance is $50.
p account.balance         # => 50













