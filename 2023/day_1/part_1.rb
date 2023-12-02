# Day 1 Part 1

calibration_sum = 0

File.foreach('input.txt') do |line|
  this_calibration = ''
  # first char
  line.each_char do |char|
    next unless char.to_i.positive?

    this_calibration << char
    break
  end
  # last char
  (line.length - 1).downto(0) do |i|
    next unless line[i].to_i.positive?

    this_calibration << line[i]
    break
  end

  calibration_sum += this_calibration.to_i
end

puts calibration_sum
