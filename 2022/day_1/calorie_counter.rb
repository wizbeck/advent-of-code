require 'pry'

INPUT = Pathname.new("#{Dir.pwd}/day_1/input.txt")
DELIMITER = "\n".freeze

def elf_with_most_calories
  # returns an array of each elf's calorie_counts
  calories_by_elf = parse_calories_per_elf

  most_calories = 0

  calories_by_elf.each do |cals|
    e = Elf.new(cals)
    most_calories = [most_calories, e.calories].max
  end

  puts most_calories
end

# Struct where calories is an array of calorie elements in string form
# the struct converts array elements to int, and sums them to list the total calories
#
Elf = Struct.new(:calories) do
  def initialize(calories)
    self.calories = muddle(calories)
  end

  def muddle(array)
    array.grep(/\d+/, &:to_i).sum
  end
end

def parse_calories_per_elf(pathname = INPUT, delimiter = DELIMITER)
  lines = File.read(pathname).split(delimiter * 2)
  lines.map! { |line| line.split(delimiter) }
end

elf_with_most_calories

# PART TWO: WE WANT TO RETURN THE TOP THREE with most_calories
