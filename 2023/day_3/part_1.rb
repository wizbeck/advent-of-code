# engine schematic

# include numbers which have _adjacent_ (including diagnoal)
# need to setup some kind of tracker state,
#   to verify that a number from the specific position and
#   row is not added to the sum twice
#
#
# Plans for solving:
# Implement some kind of state tracking to keep track of numbers we've already added to the sum of total numbers
#   near special characters, we need the state to hold some kind of data structure for easy lookup of:
#   1. the row they appeared on
#   2. the starting index of the number,
#   3. the ending index of the number
#
# On line scanning we only want to evaluate when we come across special characters.
# When we come across a special_character, we check all the indices around it if theres a number adjacent to it,
# previous rows count (we need to be able to retrieve the line previously iterated)
SPECIAL_CHARS = /[^a-zA-Z0-9_.]/.freeze
NUMBERS = /\d/.freeze

def scannable_chunk(line_length, start_of_num, end_of_num)
  starting_range = start_of_num.zero? ? 0 : start_of_num - 1
  ending_range = if end_of_num.zero?
                   0
                 elsif end_of_num == line_length
                   end_of_num
                 else
                   end_of_num + 1
                 end

  starting_range..ending_range
end

def any_special_chars_adjacent?(lines, row, start_of_num, end_of_num)
  range = scannable_chunk(lines[row].length - 1, start_of_num, end_of_num)
  # check previous line same range of numbers if possible
  unless row.zero?
    above_row = row - 1
    return true if SPECIAL_CHARS.match?(lines[above_row][range])
  end
  # check same row, adjacent to starting num and ending num indexes
  return true if SPECIAL_CHARS.match?(lines[row][range])

  # check next line scannable_chunk
  unless row == (lines.length - 1)
    below_row = row + 1
    return true if SPECIAL_CHARS.match?(lines[below_row][range])
  end

  false
end

# vv Script vv

lines = File.readlines('input.txt', chomp: true)
# store the valid numbers that we come across in a hash table for lookup by row, start, end indexes to see if we've already traversed them
# [row, start_index, end_index] => number
number_addresses = {}

# loop through each row(line)
lines.each_with_index do |content, row_index|
  start_of_num = nil
  end_of_num = nil
  # loop through individual characters of the line
  0.upto(content.length) do |i|
    next unless NUMBERS.match?(content[i])

    start_of_num ||= i
    if NUMBERS.match?(content[i + 1])
      end_of_num = i + 1
    else
      end_of_num = i
      num_addr = [row_index, start_of_num, end_of_num]

      # if special_character_adjacent to any numbers between start and end of string
      if any_special_chars_adjacent?(lines, *num_addr)
        number_addresses[num_addr] = content[start_of_num..end_of_num]
        start_of_num = nil
        end_of_num = nil
      else
        start_of_num = nil
      end
    end
  end
end

# Solution
puts number_addresses.values.reduce(0) { |sum, acc| sum + acc.to_i }
