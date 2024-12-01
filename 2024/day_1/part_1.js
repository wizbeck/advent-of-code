// location id
/**
 * List of pairs
 * sort pairs in ascending order
 * difference in distances apart
 * sum the differences
 */
const fs = require("fs");
const path = require("path");

const inputPath = path.join(__dirname, "input.txt");
const data = fs.readFileSync(inputPath, "utf-8");
const pairs = data.split("\n");

const lhs = [];
const rhs = [];

// convert strings with the whitespaces into an array of pairs of numbers
const splitPoint = /\s+/;

// convert each side of pair into integer and store in left hand or right hand side collections
for (let pair of pairs) {
  const splitPair = pair.split(splitPoint);
  lhs.push(parseInt(splitPair[0]));
  rhs.push(parseInt(splitPair[1]));
}

// sort to ascending order
lhs.sort();
rhs.sort();

let distanceSum = 0;

for (let i = 0; i < lhs.length; i++) {
  const distanceBetween = Math.abs(rhs[i] - lhs[i]);
  distanceSum += distanceBetween;
}

// Solution
console.log(distanceSum);
