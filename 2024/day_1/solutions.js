// Imports
const fs = require("fs");
const path = require("path");

// Initialize
const inputPath = path.join(__dirname, "input.txt");
const data = fs.readFileSync(inputPath, "utf-8");
const pairs = data.split("\n");
const lhs = [];
const rhs = [];

// Part One
function partOneSolution(lhs, rhs) {
  const splitPoint = /\s+/;

  for (let pair of pairs) {
    const splitPair = pair.split(splitPoint);
    lhs.push(parseInt(splitPair[0]));
    rhs.push(parseInt(splitPair[1]));
  }

  lhs.sort();
  rhs.sort();

  let partOneSolutionValue = 0;

  for (let i = 0; i < lhs.length; i++) {
    const distanceBetween = Math.abs(rhs[i] - lhs[i]);
    partOneSolutionValue += distanceBetween;
  }

  console.log("Part One Answer: ", partOneSolutionValue);
}

// Part Two
// function relies on what was done in the partOneSolution function
// where lhs and rhs parameters are arrays of numbers and sorted from partOneSolution
function partTwoSolution(lhs, rhs) {
  const rhsMap = {};
  for (const rhp of rhs) {
    rhsMap[rhp] ||= 0;
    rhsMap[rhp] += 1;
  }

  let partTwoSolutionValue = 0;

  for (const lhp of lhs) {
    const similarityScore = lhp * rhsMap[lhp] || 0;
    partTwoSolutionValue += similarityScore;
  }

  console.log("Part Two Answer: ", partTwoSolutionValue);
}

// Call to return answers
partOneSolution(lhs, rhs);
partTwoSolution(lhs, rhs);
