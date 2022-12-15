// Rock Paper Scissor with an encrypted "strategy guide"
/**
 * Given:
 * A Y -> A = 'Rock', Y = 'Paper'
 * B X -> B = 'Paper' X = 'Scissors'
 * C Z -> C = 'Scissors' Z = 'Rock'
 * 
 * Point Values:
 * 
 * 
 * Regardless of win/loss/draw, points are added to total score for the sign chosen,
 * You could +lose+ and still get 3 points for choosing scissors -> Z
 */

const fs = require('fs');

// INPUT_PATH is absolute path to where your input is stored
const INPUT_PATH = "/Users/wbeck/code/advent-of-code/2022/day_2/input.txt";

// ScoreTables
const SCORING = {
  outcomes: {
    win: 6,
    loss: 0,
    draw: 3
  },
  signs: {
    'rock': 1,
    'paper': 2,
    'scissors': 3
  }
}


class Round {
  // DECODE lines from input with this
  static SIGNS = {
    'A': 'rock',
    'B': 'paper',
    'C': 'scissors',
    'X': 'rock',
    'Y': 'paper',
    'Z': 'scissors'
  };

  constructor(line) {
    let letters = line.split(' ');
    console.log(letters);
    this.opponent = Round.SIGNS[letters[0]];
    this.me = Round.SIGNS[letters[1]];
    this.score = this.calcScore();
  }

  calcScore() {
    if (this.me === 'rock') {
      return this.imRock();
    }
    if (this.me === 'paper') {
      return this.imPaper();
    }
    if (this.me === 'scissors') {
      return this.imScissors();
    }
  }

  // we know we are rock here, so we can determine the outcome based on what opponent is 
  imRock() {
    let total = 0;
    if (this.opponent === 'paper') {
      total = SCORING.outcomes.loss;
    } else if (this.opponent === 'scissors') {
      total = SCORING.outcomes.win;
    } else {
      total = SCORING.outcomes.draw;
    };
    total += SCORING.signs[this.me]; // this.me should be 'rock'
    return total;
  }

  imPaper() {
    let total = 0;
    if (this.opponent === 'scissors') {
      total = SCORING.outcomes.loss;
    } else if (this.opponent === 'rock') {
      total = SCORING.outcomes.win;
    } else {
      total = SCORING.outcomes.draw;
    };
    total += SCORING.signs[this.me]; // this.me should be 'scissors'
    return total;
  }

  imScissors() {
    let total = 0;
    if (this.opponent === 'rock') {
      total = SCORING.outcomes.loss;
    } else if (this.opponent === 'paper') {
      total = SCORING.outcomes.win;
    } else {
      total = SCORING.outcomes.draw;
    };
    total += SCORING.signs[this.me]; // this.me should be 'scissors'
    return total;
  }

}

// returns an array of a string winner pair
// ['A Y', 'B Z', ...]
const input = fs.readFileSync(INPUT_PATH, 'utf-8').split('\n');

let totalScore = 0;

for (let line of input) {
  // we need to split the strings separated in each round for the encrypted values
  let round = new Round(line);
  totalScore +=(round.score)
}


console.log(totalScore);

