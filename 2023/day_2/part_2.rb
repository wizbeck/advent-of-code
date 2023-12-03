def parsed_game_line(line)
  game_id_chunk, handfuls_chunk = line.split(': ')
  game_id = game_id_chunk[5..]
  handfuls = handfuls_chunk.split('; ')
  {
    'id' => game_id,
    'handfuls' => handfuls.map do |hf|
      hash = {}
      hf.split(', ').map(&:split).each { |s| hash[s[-1]] = (s[0] || 1).to_i }
      hash
    end
  }
end

# Script
sum_of_lowest_powers = 0

File.foreach('input.txt', chomp: true) do |line|
  handfuls = parsed_game_line(line)['handfuls']
  max_red = -Float::INFINITY
  max_green = -Float::INFINITY
  max_blue = -Float::INFINITY
  handfuls.each do |hf|
    max_red = [max_red, hf['red'] || 1].max
    max_green = [max_green, hf['green'] || 1].max
    max_blue = [max_blue, hf['blue'] || 1].max
  end
  sum_of_lowest_powers += max_red * max_green * max_blue
end

puts "Sum of lowest powers: #{sum_of_lowest_powers}"
