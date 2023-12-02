# Day 1 Part 2

WTN = {
  'one' => '1',
  'two' => '2',
  'three' => '3',
  'four' => '4',
  'five' => '5',
  'six' => '6',
  'seven' => '7',
  'eight' => '8',
  'nine' => '9'
}.freeze

NUMBER_WORD_REGEX = /(?<number>one|two|three|four|five|six|seven|eight|nine)/.freeze

cal_sum = 0

File.foreach('input.txt') do |line|
  chomped = line.chomp
  # gather possible regex matches
  calibration = ''
  potential_number_word = ''
  chomped.each_char do |char|
    if char.to_i.positive?
      calibration << char
      break
    else
      potential_number_word << char
      capture = NUMBER_WORD_REGEX.match(potential_number_word)
      if capture
        calibration << WTN[capture[:number]]
        break
      end
    end
  end

  # reset potential_number_word and start on reverse
  potential_number_word = ''
  (chomped.length - 1).downto(0) do |i|
    if chomped[i].to_i.positive?
      calibration << chomped[i]
      break
    else
      potential_number_word = chomped[i] + potential_number_word
      capture = NUMBER_WORD_REGEX.match(potential_number_word)
      if capture
        calibration << WTN[capture[:number]]
        break
      end
    end
  end
  cal_sum += calibration.to_i
end

puts cal_sum
