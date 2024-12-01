require 'pry'
# Part 2 Challenge
# Requirements:
# A gear is any * symbol that is adjacent to exactly two part numbers.
# Its gear ratio is the result of multiplying those two numbers together.
NOT_A_NUMBER = /\D/.freeze
gears = {}
# Starting placeholders for starting index of number and ending index of number
lines = File.readlines('input.txt', chomp: true)
lines.each_with_index do |line, row|
  line.each_char.with_index do |char, column|
    next unless char == '*'

    adjacent_parts = []

    unless row.zero?
      line_above = lines[row - 1]
      adjacent_parts_above = line_above[adjacent_range(line, column)].split(NOT_A_NUMBER)
      adjacent_parts.concat(adjacent_parts_above)
      passed_adjacent_part = complete_part_number(line, column - 1, reverse: true)
      next if adjacent_parts.length > 2
    end

    # check column before in current row
    unless column.zero?
      ch = line[column - 1]
      adjacent_parts += 1 if ch.to_i.to_s == ch
      next if adjacent_parts.length > 2
    end

    # check column after in current row
    unless column == line.length - 1
      ch = line[column + 1]
      adjacent_parts += 1 if ch.to_i.to_s == ch
      complete_part_number(line, column + 1)
    end

    unless row == lines.length - 1
      line_below = lines[row + 1]
      adjacent_parts_below = line_below[adjacent_range(line, column)].split(NOT_A_NUMBER)
      adjacent_parts += adjacent_parts_below
      next if adjacent_parts > 2
    end

    # Need to find complete part number not the integer directly adjacent to the star character...

  end
end


# When we land on a number, we can assume this is a valid part number and
def complete_part_number(line, pos, reverse: false)
  incrementor = reverse ? -1 : 1
  part_number = line[pos]
  current_pos = pos + incrementor
  # use incrementor to loop forwards or backwards until we find a non-number character to stop and return the total string
  while /\d/.match?(line[current_pos])
    if incrementor.positive?
      part_number << line[current_pos]
    else
      part_number = line[current_pos] + part_number
    end
    current_pos += incrementor
  end
  part_number
end

def adjacent_range(line, col)
  from = [col - 1, col].max
  to = [col + 1, line.length - 1].min
  from..to
end
