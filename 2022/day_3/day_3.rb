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

PART_ONE_SOLVED = true
PART_TWO_SOLVED = true


class Rucksack
  attr_reader :all_contents, :first, :second, :overlap
  @@all = []

  PRIORITY = [*'a'..'z', *'A'..'Z'].map.with_index(1) do |char, priority|
    [char, priority]
  end.to_h.freeze

  def initialize(contents)
    @all_contents = contents
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

  # returns +Rucksack+ objects grouped by an amount +number+
  def self.in_groups_of(number)
    groups = []
    all.each_slice(number) do |group|
      groups << group
    end
    groups
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

# PART ONE - overlaps between two compartments of a +Rucksack+

input_path = Pathname.new(Dir.getwd).join('day_3', 'input.txt')

file_lines = File.readlines(input_path, chomp: true)

if PART_ONE_SOLVED
  sum_of_priorities = 0
  # for each half, we find the strings that are duplicate across each compartment
  file_lines.each do |line|
    r = Rucksack.new(line)
    sum_of_priorities += r.overlap_priority_sum
  end

  puts "PART ONE ANSWER: #{sum_of_priorities}"
end
# END PART ONE

# PART TWO
# Problem: 
# rucksack contents are grouped per 3 elves,
#   find the overlap in all 3 rucksacks(lines)
# each group of 3 has a correlating badge
# badges are not 'authenticated'

if PART_TWO_SOLVED
  sum_of_priorities_grouped = 0
  rucksack_groups = Rucksack.in_groups_of(3)
  badges = []
  rucksack_groups.each do |rg|
    # split chars for each rucksack into an array of chars
    rs_char_arrays = rg.map { |rs| rs.all_contents.split('') }
    # finding the intersection between all three, should reveal a single character
    badge = (rs_char_arrays.first & rs_char_arrays[1] & rs_char_arrays.last).first
    badges << badge
    sum_of_priorities_grouped += Rucksack::PRIORITY[badge]
  end
  puts "PART TWO ANSWER: #{sum_of_priorities_grouped}"
end
# END PART TWO