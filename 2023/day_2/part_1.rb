MAXIMUMS = {
  'red' => 12,
  'green' => 13,
  'blue' => 14
}.freeze

def parsed_game_line(line)
  game_id_chunk, handfuls_chunk = line.split(': ')
  game_id = game_id_chunk[5..]
  handfuls = handfuls_chunk.split('; ')
  {
    'id' => game_id,
    'handfuls' => handfuls.map do |hf|
      hash = {}
      hf.split(', ').map(&:split).each { |s| hash[s[-1]] = s[0].to_i }
      hash
    end
  }
end

def possible?(game, config = MAXIMUMS)
  game['handfuls'].each do |hf|
    if hf['red'].to_i > config['red'] || hf['green'].to_i > config['green'] || hf['blue'].to_i > config['blue']
      return false
    end
  end

  true
end

# Given a string in itself how do we manipulate this to be better by a single

# Script
possible_games = []
game_id_sum = 0
File.foreach('input.txt', chomp: true) do |line|
  game = parsed_game_line(line)
  next unless possible?(game)

  possible_games << game
  game_id_sum += game['id'].to_i
end

puts "#{possible_games.size} _possible_ games whose id total to: #{game_id_sum}"
