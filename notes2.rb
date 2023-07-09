module Timewarpable
  def time_stop
    puts "I am a #{self.class} and I have the ability to manipulate the " \
        "fabric of time!"
  end
end

module Illusionable
  def mirage
    puts "I am a #{self.class} and I have the ability to alter how people " \
        "see the world!"
  end
end

class SorcerySchool
  @@spells = ['fireball', 'earthquake', 'wall of water', 'lightning bolt']

  def self.assign_spell
    @@spells.empty? ? 'TBD' : @@spells.delete(@@spells.sample)
  end
end

class SorceryStudent
  ENERGY_RANGE = (100..200).to_a

  def initialize
    @unique_spell = SorcerySchool.assign_spell
  end

  def to_s
  student_info = <<~INFO
  ============================
  School of Sorcery: #{self.class}
  Magical Energy: #{magical_energy}
  Unique Spell: #{unique_spell}
  Artifact: #{artifact}
  Robe Color: #{robe_color}
  ============================
  INFO
  end

  private

  attr_reader :magical_energy, :unique_spell, :artifact, :robe_color

  def calc_magical_energy
    @magical_energy = self.class::ENERGY_RANGE.sample
  end
end

class Illusionist < SorceryStudent
  include Illusionable

  def initialize
    super
    @artifact = 'crystal ball'
    @robe_color = 'purple'
    calc_magical_energy
  end
end

class Enchanter < Illusionist
  ENERGY_RANGE = (150...250).to_a

  def initialize
    super
    @artifact = 'crystal ball'
    @robe_color = 'gold'
    calc_magical_energy
  end
end

class Necromancer < SorceryStudent
  include Timewarpable

  ENERGY_RANGE = (75..175).to_a

  def initialize
    super
    @artifact = 'wooden staff'
    @robe_color = 'black'
    calc_magical_energy
  end

  def create_zombie
    puts "I am a #{self.class} and I can make a Zombie!"
  end
end

class Conjurer < SorceryStudent
  include Timewarpable
  include Illusionable

  def initialize
    super
    @artifact = 'silver wand'
    @robe_color = 'green'
    calc_magical_energy
  end
end

# new instances of each class, with the last repeated to see `TBD` spell assignment
enchanter = Enchanter.new
illusionist = Illusionist.new
necromancer = Necromancer.new
conjurer = Conjurer.new
conjurer2 = Conjurer.new

#printing info for each instance:
puts enchanter
puts illusionist
puts necromancer
puts conjurer
puts conjurer2

# invocations of the required methods
illusionist.mirage
enchanter.mirage
necromancer.time_stop
necromancer.create_zombie
conjurer.mirage
conjurer.time_stop

