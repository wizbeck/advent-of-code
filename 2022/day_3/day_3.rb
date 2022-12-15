# Based on input of random alphanumeric strings,
# Plan
#  1. split string in half str.length / 2,
#  2. hashify the two substrings as frequency counters?
#  3. for each counter hash, check if currentKey traversed is present in the other subtstring counter hash
#  4. if yes, store that value in a separate array
#  5. sum the priority values at the end of all data structure traversal
# 
# Should I build classes, or just procedurally solve the first part.
# CLasses make things easier to change for part 2's
#  but this is more raw data structures and algos
PATH = Pathname.new(Dir.getwd).join('input.txt')

rucksacks = File.readlines()