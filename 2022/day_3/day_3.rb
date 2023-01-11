# Based on input of random alphanumeric strings,
# Plan
#  1. split string in half str.length / 2,
#  2. hashify the two substrings as frequency counters?
#  3. for each counter hash, check if currentKey traversed is present in the other subtstring counter hash
#  4. if yes, store that value in a separate array
#  5. sum the priority values at the end of all data structure traversal
# 

require 'pathname'
require 'pry'


class Rucksack
  attr_reader :first, :second, :overlap
  @@all = []

  PRIORITY = [*'a'..'z', *'A'..'Z'].map.with_index(1) do |char, priority|
    [char, priority]
  end.to_h.freeze

  def initialize(contents)
    @first, @second = parse_contents(contents)
    @overlap = overlapping_contents
    @@all << self
  end

  # converts overlap into the priority sum
  def overlap_priority_sum
    return 0 if overlap.empty?
    overlap.reduce(0){|sum, letter| sum + PRIORITY[letter]}
  end

  def self.all
    @@all
  end

  private

  # returns a 2 element array to assign first and second compartments
  def parse_contents(contents)
    half = (contents.length - 1) / 2
    [contents[0..half], contents[(half + 1)..]]
  end

  # returns the letters which occur in both compartments of the rucksack object
  def overlapping_contents
    first.split('').uniq & second.split('').uniq
  end
end

input_path = Pathname.new(Dir.getwd).join('day_3', 'input.txt')

file_lines = File.readlines(input_path, chomp: true)

sum_of_priorities = 0
# for each half, we find the strings that are duplicate across each compartment
file_lines.each do |line|
  r = Rucksack.new(line)
  sum_of_priorities += r.overlap_priority_sum
end

puts sum_of_priorities

# FIRST GUESS 12501 -> WRONG! -> TOO HIGH
# What does this mean that the answer was too high?
# That means that some of the overlap that was counted was counted multiple times, or too many characters were overlapping.
#   This could be due to the splitting of each compartment, and flooring the half length, creating additional overlap at the bisects of the file lines
#   when creating Rucksack objects